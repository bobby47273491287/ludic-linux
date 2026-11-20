#!/usr/bin/bash
set -euo pipefail

# Provide the writable paths expected while preparing a live root filesystem.
mkdir -p "$(realpath /root)"
mount -o remount,rw /proc/sys || true

dnf install -y dracut-live livesys-scripts grub2-efi-x64-cdboot

kernel=$(kernel-install list --json pretty | jq -r '.[] | select(.has_kernel == true) | .version' | sort -V | tail -n 1)
if [[ -z "$kernel" || ! -d "/usr/lib/modules/$kernel" ]]; then
    echo "Could not find the kernel needed to make the Ludic live ISO." >&2
    exit 1
fi

DRACUT_NO_XATTR=1 dracut -v --force --reproducible --no-hostonly \
    --add "dmsquash-live dmsquash-live-autooverlay" \
    "/usr/lib/modules/${kernel}/initramfs.img" "${kernel}"

# Start directly in the KDE live session. No disk installer is included.
if grep -q '^livesys_session=' /etc/sysconfig/livesys; then
    sed -i 's/^livesys_session=.*/livesys_session=kde/' /etc/sysconfig/livesys
else
    echo 'livesys_session=kde' >> /etc/sysconfig/livesys
fi
systemctl enable livesys.service livesys-late.service

# Skip setup and update services that are intended for a persistent install.
for unit in \
    bazzite-hardware-setup.service \
    bazzite-user-setup.service \
    bazzite-flatpak-manager.service \
    ublue-hardware-setup.service \
    ublue-user-setup.service \
    ublue-system-setup.service \
    bootloader-update.service \
    rpm-ostreed-automatic.timer \
    uupd.timer \
    flatpak-add-fedora-repos.service; do
    systemctl disable "$unit" >/dev/null 2>&1 || true
done

for unit in bazzite-user-setup.service ublue-user-setup.service; do
    systemctl --global disable "$unit" >/dev/null 2>&1 || true
done

# Leave Steam available in the app menu without launching it automatically.
rm -f /etc/skel/.config/autostart/steam*.desktop

# Give live-session operations enough temporary space and keep the Flatpak
# deployment unchanged while the preview is running.
rm -rf /var/tmp
mkdir -p /var/tmp
cat > /etc/systemd/system/var-tmp.mount <<'EOF'
[Unit]
Description=Temporary space for the Ludic live session

[Mount]
What=tmpfs
Where=/var/tmp
Type=tmpfs
Options=size=50%,nr_inodes=1m

[Install]
WantedBy=local-fs.target
EOF
systemctl enable var-tmp.mount

cat > /etc/systemd/system/var-lib-flatpak.mount <<'EOF'
[Mount]
Type=none
What=/var/lib/flatpak
Where=/var/lib/flatpak
Options=bind,ro

[Install]
WantedBy=multi-user.target
EOF
systemctl enable var-lib-flatpak.mount

# Titanoboa expects EFI boot files and an ISO boot menu in the image.
mkdir -p /boot/efi /usr/lib/bootc-image-builder
cp -av /usr/lib/efi/*/*/EFI /boot/efi/
cp /src/iso.yaml /usr/lib/bootc-image-builder/iso.yaml

rm -f /etc/localtime
systemd-firstboot --timezone UTC
dnf clean all

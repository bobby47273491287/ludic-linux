# Try or install Ludic

## Try Ludic without installing

First build the Ludic images, then run **Build Ludic live preview** in the repository's GitHub Actions tab and download its artifact. That ISO starts a temporary Ludic desktop and contains no install option, so it will not automatically install Ludic onto a drive.

On Windows, the safest first look is to attach the ISO to a virtual machine and start the VM. Choose the **AMD/Intel** flavor for a VM, and give it at least 8 GB of memory and 4 CPU cores for a usable desktop. The VM will not use your computer's graphics card for real game performance. For a direct check of your graphics card, write the ISO to a USB drive, restart, and choose the USB from the one-time boot menu. Choose **Try Ludic (live desktop)**. Remove the USB and restart to return to Windows.

The preview session is temporary. Files or settings created in it are discarded at shutdown. Use it to explore KDE and the included apps; game performance in the live session is not representative of an installed system.

When you are ready to install, build the separate **Build a Ludic installer** ISO below.

## Pick the graphics flavor

- Most AMD and Intel systems: **Ludic**.
- NVIDIA systems: choose **Ludic NVIDIA**.
- Newer Turing-generation NVIDIA cards and later: **Ludic NVIDIA Open** is also available.

If you do not know your graphics model, check it in your current operating system before choosing an image. NVIDIA cards need the image with the matching driver stack.

## Make the installer USB

1. Download the ISO artifact from the **Build a Ludic installer** GitHub Actions run.
2. Write the ISO to a USB drive using Fedora Media Writer or another USB imaging tool.
3. Boot the target PC from the USB drive.
4. Follow the installer screens and connect to the internet when prompted.
5. After the first boot, sign in and allow the initial game-launcher setup to finish.

The first prototype inherits the upstream Bazzite installer flow. It installs the Ludic system image over the network and needs internet access.

## Before installing

- Back up files that matter to you.
- Confirm the target PC has a 64-bit x86 processor and UEFI boot support.
- Check whether your multiplayer games support Linux and their anti-cheat setup.
- Disconnect backup drives if you are unsure which disk the installer will use.

## Recover from a bad system update

The system image is built on Fedora Atomic technology. If an update causes trouble, use the previous deployment from the boot menu or the upstream Bazzite rollback instructions. Your personal files are stored separately from the operating-system image.

## Current limits

The first prototype targets ordinary x86_64 desktop and laptop PCs. It has not yet been validated across a hardware lab, and Ludic-specific screenshots or recovery utilities are not part of this first build.

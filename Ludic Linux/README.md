# Ludic Linux

**A gaming desktop that still feels like your PC.**

Ludic is a desktop-first Linux distribution concept for PC gaming. It starts with KDE Plasma and the gaming-ready Fedora Atomic system from Bazzite, then adds Ludic branding, a small set of useful game launchers, and straightforward installer-image builds.

## What you get

- KDE Plasma desktop and Steam from the Bazzite base.
- A choice of AMD/Intel, NVIDIA, or modern NVIDIA graphics images.
- Heroic Games Launcher for Epic, GOG, and Amazon libraries, plus ProtonUp-Qt for managing community compatibility tools.
- Atomic system updates with a previous deployment available for rollback.
- A custom Ludic wallpaper and operating-system name.
- A GitHub build workflow for the system images and a separate workflow for generating an install USB image.

Ludic does not promise that every game works. Game publishers control Linux and anti-cheat support; check the game’s current compatibility before switching your main PC.

## Project status

This is the first buildable prototype: recipes, branding, design notes, and CI workflows are ready. The installer ISO and system images are not included yet. This Windows workspace has no Linux build environment, so the image build needs to run through GitHub Actions or on a Linux machine. The first GitHub build also needs a Cosign signing key configured; see [Build and release](docs/BUILD.md).

## Hardware flavors

| Build | Choose it for |
| --- | --- |
| ludic | AMD or Intel graphics |
| ludic-nvidia | NVIDIA graphics using the standard driver image |
| ludic-nvidia-open | Supported newer NVIDIA GPUs using the open kernel module |

The NVIDIA open-module build is for Turing-generation GPUs and newer. If you are unsure which image fits your GPU, check [Bazzite’s current image guide](https://docs.bazzite.gg/General/FAQ/) before installing.

## Build it

1. Create a GitHub repository from this folder and enable GitHub Actions.
2. Generate a Cosign key pair. Keep the private key private; add it to repository Actions secrets as SIGNING_SECRET. Make the public key available to the build as COSIGN_PUBLIC_KEY. More detail is in [Build and release](docs/BUILD.md).
3. Run **Build Ludic images** in the Actions tab. The workflow publishes the three system images to GitHub Container Registry.
4. Run **Build a Ludic installer** and choose your graphics flavor. Download the ISO from that workflow’s Artifacts section.

For local Linux builds and the image-based install flow, see [Build and release](docs/BUILD.md) and [Install Ludic](docs/INSTALL.md).

## Design

Ludic uses a graphite background with cool cyan light and restrained warm accents. KDE stays familiar and keyboard-and-mouse first; the system is not forced into a console interface. See the [design brief](docs/DESIGN.md) and the [wallpaper preview](files/system/usr/share/backgrounds/ludic/ludic-aurora.svg).

## Known limits

- This prototype targets x86_64 PCs. ARM PCs and handheld-specific interfaces are outside the first release.
- The installer is a net installer and needs a working internet connection.
- The Ludic wallpaper is included in the image for selection from KDE’s wallpaper settings; automatic default-wallpaper selection is later work.
- Game compatibility depends on each title, launcher, graphics driver, and anti-cheat configuration.
- The first release inherits the Bazzite installer and much of its desktop behavior. Ludic-specific installer screens and a dedicated settings app are later work.
- Ludic is an independent community project, not an official Fedora, Bazzite, Valve, Epic, GOG, or Amazon product.

## Upstream references

- [Bazzite image flavors and hardware guidance](https://docs.bazzite.gg/General/FAQ/)
- [Bazzite guidance for custom images](https://docs.bazzite.gg/Advanced/creating_custom_image/)
- [BlueBuild repository setup](https://blue-build.org/how-to/setup/)
- [BlueBuild installer ISO guide](https://blue-build.org/how-to/generate-iso/)
- [Heroic Games Launcher source](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher)
- [ProtonUp-Qt source](https://github.com/DavidoTek/ProtonUp-Qt)

## License

The Ludic-specific configuration and branding in this repository are offered under the MIT License. Upstream components retain their own licenses and trademarks.

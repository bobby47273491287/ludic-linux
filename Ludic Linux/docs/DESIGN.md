# Ludic Linux design brief

## Product

Ludic is a gaming-focused PC desktop for people who want a ready-to-use gaming setup without giving up a normal Linux desktop. The first edition favors reliable updates, familiar controls, and several game libraries in the same install.

## Audience and first release

- PC gamers who prefer a mouse-and-keyboard desktop.
- People moving from Windows who want Steam and other launchers ready to use.
- Users with current x86_64 desktops or laptops and AMD, Intel, or supported NVIDIA graphics.

The first release is not a handheld-only or couch-console system. A controller is welcome, but the desktop remains the default session.

## Visual identity

- **Name:** Ludic Linux
- **Tagline:** A gaming desktop that still feels like your PC.
- **Palette:** graphite, luminous cyan, and a small ember-orange accent.
- **Shape language:** a soft orbital ring and a four-point star; broad forms and quiet negative space.
- **Tone:** capable and playful, without turning the desktop into a toy.

The initial wallpaper is a scalable SVG in files/system/usr/share/backgrounds/ludic/ludic-aurora.svg. The image recipe copies it into the installed system at /usr/share/backgrounds/ludic/.

## Technical choices

| Area | First-release choice | Reason |
| --- | --- | --- |
| Base | Bazzite KDE image | It is a gaming-focused Fedora Atomic image and already handles much of the gaming stack. |
| Desktop | KDE Plasma | Flexible desktop, good controller support, and a practical fit for a desktop-first system. |
| Updates | Inherited Bazzite stable track | Keeps the image aligned with the upstream gaming system and its fixes. |
| System model | Image-based, read-only system image | Makes system changes reproducible and lets users roll back a bad deployment. |
| Game store | Steam from the base, Heroic added from Flathub | Covers Steam plus Epic, GOG, and Amazon libraries without bundling game files. |
| Compatibility tools | ProtonUp-Qt from Flathub | Gives users a graphical way to add community Proton builds when needed. |
| GPU support | Separate AMD/Intel, standard NVIDIA, and NVIDIA open-module images | NVIDIA support depends on the matching driver image. |
| Installer | BlueBuild netinstall ISO from the published image | Keeps the installer aligned with the system image users will receive. |

## Distribution behavior

Ludic keeps upstream performance and driver defaults. It does not apply global overclocking, disable security mitigations, or force a custom gaming kernel. Users can tune per-game launch options and performance settings themselves.

Heroic and ProtonUp-Qt are installed for each account on first sign-in when an internet connection is available. That keeps the system image smaller and leaves the apps updateable through the normal Flatpak path.

## Compatibility promise

Ludic provides a gaming-ready Linux environment; it cannot make a game compatible when a publisher blocks Linux or its anti-cheat stack. Compatibility varies by game and can change after a game update. The release notes should link to current compatibility sources and avoid blanket promises.

## Later releases

1. A polished first-boot welcome page with launcher, driver, and update guidance.
2. Installer branding and a Ludic recovery / troubleshooting guide.
3. Optional living-room session that users can enable without replacing the desktop.
4. Broader hardware validation, including handhelds, only after the desktop images are stable.

## Upstream sources

- [Bazzite custom-image guidance](https://docs.bazzite.gg/Advanced/creating_custom_image/)
- [Bazzite image flavors and graphics guidance](https://docs.bazzite.gg/General/FAQ/)
- [Bazzite rollback and update guide](https://docs.bazzite.gg/Installing_and_Managing_Software/Updates_Rollsbacks_and_Rebasing/)
- [BlueBuild recipe reference](https://blue-build.org/reference/recipe/)
- [BlueBuild ISO guide](https://blue-build.org/how-to/generate-iso/)

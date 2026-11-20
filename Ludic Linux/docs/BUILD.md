# Build and release

Ludic uses BlueBuild recipes based on Bazzite. The GitHub workflows build and publish three image flavors. One workflow turns a published flavor into a temporary live desktop ISO; a second workflow makes a network installer ISO.

## Before the first build

The image-signing workflow needs one Cosign key pair:

1. Install the Cosign command-line tool from the [official Cosign releases](https://github.com/sigstore/cosign/releases).
2. In PowerShell, set the key password to empty for the unattended GitHub build and generate a key pair:

   ~~~powershell
   $env:COSIGN_PASSWORD = ""
   cosign generate-key-pair
   ~~~

3. In the GitHub repository, open **Settings → Secrets and variables → Actions**. Add the contents of cosign.key as SIGNING_SECRET and the contents of cosign.pub as COSIGN_PUBLIC_KEY.
4. Keep cosign.key somewhere private and never commit it. The public key can be shared; the workflow injects it into each image so installed systems can verify image updates.

You also need a GitHub repository with Actions enabled. The workflow needs permission to write packages so it can publish images to GitHub Container Registry.

## Build and publish images

Run **Build Ludic images** from the repository’s Actions tab. Pushes to the default branch and the scheduled build also run it.

The published image names are:

- ghcr.io/OWNER/ludic:latest
- ghcr.io/OWNER/ludic-nvidia:latest
- ghcr.io/OWNER/ludic-nvidia-open:latest

Replace OWNER with the lowercase GitHub account or organization that owns the repository. After the first push, GitHub may leave the package private; change the package visibility if people outside the repository need to download the image.

## Create a live preview ISO

After the image workflow has succeeded, run **Build Ludic live preview** from the Actions tab and select the graphics flavor. Download the ISO from that workflow run's artifact. The preview boots directly to KDE Plasma and has no install option, so it is suitable for a virtual machine or a USB test session without changing the computer's drives.

The live ISO is generated with [Titanoboa](https://github.com/ublue-os/titanoboa), following the live ISO approach documented by [Bazzite](https://github.com/ublue-os/bazzite/tree/main/installer). It includes the selected Ludic image as its desktop environment. Like other live sessions, it uses temporary storage: files and settings made during the session disappear when it shuts down. Game performance in the live session is not representative of an installed system.

## Create a network installer ISO

After the image workflow has succeeded, run **Build a Ludic installer** from the Actions tab and select the graphics flavor. The ISO is attached to the workflow run as an artifact.

The ISO is a net installer: it downloads the selected system image during installation. It is not an offline copy of the full distribution.

## Build on Linux

Install BlueBuild and a supported container engine first. BlueBuild documents Docker 23+, Podman 4+, and Buildah 1.29+ as supported build tools.

Build one image locally:

~~~sh
bluebuild build ./recipes/recipe.yml
bluebuild build ./recipes/recipe-nvidia.yml
bluebuild build ./recipes/recipe-nvidia-open.yml
~~~

Generate an installer from a published image:

~~~sh
sudo bluebuild generate-iso --iso-name ludic.iso image ghcr.io/OWNER/ludic:latest
~~~

BlueBuild also documents local-recipe ISO generation. Use the published-image route for release ISOs so the installer points at the image users will actually receive.

## What the workflows do

- build-images.yml builds each recipe through the BlueBuild GitHub Action and pushes signed image tags.
- build-live-preview.yml prepares a live desktop image from the selected published flavor, builds a try-only ISO, and stores it as a GitHub Actions artifact for 30 days.
- build-installer.yml pulls the selected published image, generates a netinstall ISO, and stores it as a GitHub Actions artifact for 14 days.
- The image base tracks Bazzite’s stable image tag. The scheduled build checks upstream updates; it does not pin a Fedora major version forever.

## Upstream references

- [BlueBuild CLI installation and build commands](https://github.com/blue-build/cli)
- [BlueBuild GitHub Action inputs](https://blue-build.org/reference/github-action/)
- [BlueBuild ISO generation](https://blue-build.org/how-to/generate-iso/)
- [Cosign key-pair instructions for custom images](https://github.com/ublue-os/image-template#step-2a-creating-a-cosign-key)

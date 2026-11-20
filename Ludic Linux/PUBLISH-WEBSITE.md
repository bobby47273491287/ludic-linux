# Publish the Ludic website

The website is the `index.html`, `styles.css`, `script.js`, `favicon.svg`, and `.nojekyll` files plus the `assets` folder in this project folder. It is a static site, so it can be hosted free with GitHub Pages. The Ludic repository is public, which is supported by GitHub Free for Pages sites.

## Add the site files

Add the website files and `assets` folder to the **top level** of `bobby47273491287/ludic-linux`, beside its `README.md`. Keep the Linux distro project files in their existing `Ludic Linux` folder.

On GitHub, open the repository, select **Add file → Upload files**, and drag the website files into the page. Make sure they land at the repository top level, then commit the upload.

## Turn on GitHub Pages

1. Open the repository on GitHub and select **Settings**.
2. Open **Pages** in the left menu.
3. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
4. Set the branch to **main** and the folder to **/(root)**, then select **Save**.
5. Wait for the Pages build to finish. GitHub will show the live address on the Pages settings screen.

The expected address is `https://bobby47273491287.github.io/ludic-linux/`.

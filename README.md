# Conning Tower's Homebrew tap

[Homebrew](https://brew.sh) formulae of the Conning Tower projects.

## Silent Heritage

[Silent Heritage](https://github.com/conning-tower/SilentHeritage), the
open-source engine for Silent Hunter (1995), built from source on your Mac
(macOS 13.3 or later): no Gatekeeper warning, unlike the downloaded app.

    brew install --HEAD conning-tower/tap/silent-heritage

It installs both versions of the game: `silent_heritage` (classic) and
`silent_heritage_extended`. On the first start, the game asks for the folder
of your Silent Hunter install.

`--HEAD` builds the latest development version: the formula gets a stable
version with the next release of Silent Heritage. `brew upgrade --fetch-HEAD
silent-heritage` updates it.

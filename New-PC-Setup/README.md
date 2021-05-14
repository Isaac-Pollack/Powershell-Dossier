# Setup & Run

PowerShell script to setup a new Windows computer with my commonly used tools and settings.

Run setup.cmd as Administrator.

## Installs

- [Google Chrome](https://www.google.com.au/intl/en_au/chrome/)
- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [Notpad++](https://notepad-plus-plus.org/downloads/)
- [7zip](https://www.7-zip.org/download.html)
- [Paint.net](https://www.getpaint.net/download.html)
- [F.lux](https://justgetflux.com/)
- [Spotify](https://www.spotify.com/au/download/windows/)
- [Discord](https://discord.com/download)
- [Steam](https://store.steampowered.com/about/)
- [Obsidian.md](https://obsidian.md/)

### Dev Utils
- [Git](https://git-scm.com/downloads)
- [Putty](https://www.putty.org/)
- [Python 3](https://www.python.org/downloads/)
- [VS Code](https://code.visualstudio.com/)
- Microsoft Visual C++ Redistributables from 2015-2019
- VS Community 2017

### CLI Utils
- Sudo
- Nano
- Vim
- Pip

<br />

## Prerequisites

* ExecutionPolicy set to Bypass
* run in administrative cli
* chocolatey installed

set execution policy and install chocolatey:

`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

<br />

# Manual TODO:
- Make Chrome default browser, sign-in and import bookmarks
- Enable remote connections

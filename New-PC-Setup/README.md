# Setup & Run

PowerShell script to setup a new Windows computer with my commonly used tools and settings.

Run setup.cmd as Administrator.

## Prerequisites

* ExecutionPolicy set to Bypass
* Run in administrative cli
* Chocolatey installed

To install Chocolatey from cmd:

```console
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

## Installs

* [Google Chrome](https://www.google.com.au/intl/en_au/chrome/)
* [Firefox Dev](https://www.mozilla.org/en-US/firefox/developer/)
* [Notpad++](https://notepad-plus-plus.org/downloads/)
* [7zip](https://www.7-zip.org/download.html)
* [Paint.net](https://www.getpaint.net/download.html)
* [Spotify](https://www.spotify.com/au/download/windows/)
* [Discord](https://discord.com/download)
* [Steam](https://store.steampowered.com/about/)
* [Notion](https://www.notion.so/product)
* [Paint.Net](https://www.getpaint.net/)
* [qBittorrent](https://www.qbittorrent.org/)
* [Greenshot](https://getgreenshot.org/)
* [PNG Gauntlet](https://pnggauntlet.com/)

### Dev Utils

* [Git](https://git-scm.com/downloads)
* [Git - Large File Storage](https://git-lfs.github.com/)
* [Putty Portable](https://www.putty.org/)
* [WinSCP Portable](https://winscp.net/eng/index.php)
* [Python 3](https://www.python.org/downloads/)
* [VS Code](https://code.visualstudio.com/)
* [Git Kraken](https://www.gitkraken.com/)
* [NodeJS](https://nodejs.org/en/)
* [Rust](https://www.rust-lang.org/)
* [Golang](https://go.dev/)
* [Yarn](https://yarnpkg.com/)
* [cURL](https://curl.se/)
* [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-au&gl=au)
* [MSYS2](https://www.msys2.org/)

### Jetbrains Products

* [JB Toolbox](https://www.jetbrains.com/toolbox-app/)
* [JB Pycharm Professional](https://www.jetbrains.com/pycharm/)
* [JB DataGrip](https://www.jetbrains.com/datagrip/)

### 3D Printing

* [Cura](https://ultimaker.com/software/ultimaker-cura)

### Gaming

* [Steam](https://store.steampowered.com/)
* [Battle.net](https://us.shop.battle.net/en-us)

### Other

* [GPU-Z](https://www.techpowerup.com/gpuz/)
* [CPU-Z](https://www.techpowerup.com/download/cpu-z/)
* [MSI Afterburner](https://www.msi.com/Landing/afterburner/graphics-cards)
* [Sys Internals](https://learn.microsoft.com/en-us/sysinternals/)
* [Speccy](https://www.ccleaner.com/speccy)

These will only install if an appropriate device is installed in the system.

* [Geforce Experience](https://www.nvidia.com/en-au/geforce/geforce-experience/)
* [AMD Ryzen Chipset](https://www.amd.com/en/products/chipsets-motherboards-desktop)
* [Intel XTU & Intel DSA](https://www.intel.com/content/www/us/en/download/17881/intel-extreme-tuning-utility-intel-xtu.html)
* [NZXT Cam](https://nzxt.com/en-AU/software/cam)

### System Tweaks

* Sticky Keys turned OFF
* Display is switched to Extend Screen
* Disable all USB devices power saving
* Disable all network adapters power saving
* Prompt for enabling remote-desktop
* Prompt for reboot

<br />

## Manual TODO

* Make Firefox default browser, sign-in and import bookmarks
* Edit startup applications using Autoruns (SysInternals)
* Run MSYS2 Terminal and run the following command:

```console
pacman -S --needed base-devel mingw-w64-x86_64-toolchain
```

* [Setup MSYS2 Terminal in Windows Terminal](https://www.msys2.org/docs/terminals/)

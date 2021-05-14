# Setup & Run

PowerShell script to setup a new Windows computer with my commonly used tools and settings.

Run setup.cmd as Administrator.

## Prerequisites

* ExecutionPolicy set to Bypass
* run in administrative cli
* chocolatey installed

set execution policy and install chocolatey:

`Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

# Manual TODO:
- Make Chrome default browser, sign-in and import bookmarks
- Enable remote connections

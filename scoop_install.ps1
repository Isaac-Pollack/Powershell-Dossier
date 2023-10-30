# Allow the script to run
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Write-Output 'Beginning Scoop.sh Automated App Installation' -foregroundColor "Yellow"

# Download install script, for advanced install
Invoke-RestMethod get.scoop.sh -outfile 'install.ps1'

# Bypass proxy, install all global apps in a seperate directory.
.\install.ps1 -ScoopDir 'C:\Scoop\Applications' -ScoopGlobalDir 'C:\Scoop\GlobalApplications' -NoProxy

# Buckets
scoop bucket add extras # https://github.com/ScoopInstaller/Extras
scoop bucket add java # https://github.com/ScoopInstaller/Java/wiki
scoop bucket add versions # https://github.com/ScoopInstaller/Versions
scoop bucket add nonportable # https://github.com/ScoopInstaller/Nonportable
scoop bucket add jetbrains # https://github.com/shovel-org/Windows-JetBrains-Bucket
scoop bucket add nerd-fonts # https://github.com/matthewjberger/scoop-nerd-fonts

# Misc. Global Installs
scoop install sudo # UNIX-like Sudo
sudo scoop install sysinternals --global
sudo scoop install windows-terminal --global

# General Installs
scoop install vscode
scoop install firefox-developer
scoop install googlechrome
scoop install 7zip
scoop install notepadplusplus
scoop install greenshot
scoop install paint.net
scoop install spotify
scoop install discord
scoop install notion
scoop install qbittorrent

# CLI
sudo scoop install git git-lfs --global
sudo scoop install yarn --global
sudo scoop install curl --global

# Runtimes/Environments
sudo scoop install python --global
sudo scoop install rust --global
sudo scoop install go --global
sudo scoop install nodejs --global # Latest NodeJS
sudo scoop install openjdk8-redhat-jre --global
sudo scoop install openjdk20 --global # Latest OpenJDK
sudo scoop install vcredist --global

# Misc Dev
sudo scoop install base64 --global
sudo scoop install putty --global
sudo scoop install winscp --global
sudo scoop install base64 --global

# Fonts
scoop install nerd-fonts/JetBrains-Mono
scoop install nerd-fonts/JetBrainsMono-NF

scoop install nerd-fonts/Iosevka-NF
scoop install nerd-fonts/Iosevka-NF-Mono

scoop install nerd-fonts/FiraCode-NF
scoop install nerd-fonts/FiraCode-NF-Mono

# Run updater just in case
scoop update *

# Cleanup
scoop cleanup *; scoop cache rm -a
Write-Output 'Scoop Script Complete, enjoy!' -foregroundColor "Green"

# Non Scoop System Tweaks
Write-Output 'Beginning various PC tweaks' -foregroundColor "Yellow"

# Disable Sticky Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506" -Verbose
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Type String -Value "58" -Verbose

# Configure windows display settings
displayswitch/extend Extend screen

function disableUsbHubPowerSaving {
  $hubs = Get-WmiObject Win32_USBHub
  $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi
  foreach ($p in $powerMgmt) {
    $IN = $p.InstanceName.ToUpper()
    foreach ($h in $hubs) {
      $PNPDI = $h.PNPDeviceID
      if ($IN -like "*$PNPDI*") {
        write-host "[USB HUB power saving feature disabled]" -foregroundcolor "green"
        $p.enable = $False
        $p.psbase.put() >> $null
      }
    }
  }
}

# Turn off Power Saving for PC components
function disableNetAdapterPowerSaving {
  $PhysicalAdapters = Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.PNPDeviceID -notlike "ROOT\*" `
      -and $_.Manufacturer -ne "Microsoft" -and $_.ConfigManagerErrorCode -eq 0 -and $_.ConfigManagerErrorCode -ne 22 }

  foreach ($PhysicalAdapter in $PhysicalAdapters) {
    $PhysicalAdapterName = $PhysicalAdapter.Name
    $DeviceID = $PhysicalAdapter.DeviceID
    if ([Int32]$DeviceID -lt 10) {
      $AdapterDeviceNumber = "000" + $DeviceID
    }
    else {
      $AdapterDeviceNumber = "00" + $DeviceID
    }

    $KeyPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\$AdapterDeviceNumber"
    if (Test-Path -Path $KeyPath) {
      $PnPCapabilitiesValue = (Get-ItemProperty -Path $KeyPath).PnPCapabilities
      if ($PnPCapabilitiesValue -eq 24) {
        write-host ""$PhysicalAdapterName" power saving feature already disabled!" -foregroundcolor "green"
      }
      if ($PnPCapabilitiesValue -eq 0) {
        try {
          #setting the value of properties of PnPCapabilites to 24, it will disable save power option.
          Set-ItemProperty -Path $KeyPath -Name "PnPCapabilities" -Value 24 | Out-Null
          write-host ""$PhysicalAdapterName" power saving feature disabled!" -foregroundcolor "green"
        }
        catch {
          write-host "Failed to disable power saving of network adapter" -foregroundColor "red"
        }
      }
      if ($null -eq $PnPCapabilitiesValue) {
        try {
          New-ItemProperty -Path $KeyPath -Name "PnPCapabilities" -Value 24 -PropertyType DWord | Out-Null
          write-host ""$PhysicalAdapterName" power saving feature disabled" -foregroundcolor "green"
        }
        catch {
          write-host "Failed to disable power saving of network adapter" -foregroundcolor "red"
        }
      }
    }
    else {
      Write-Warning "The path ($KeyPath) not found."
    }
  }
}

# Enable Remote Desktop
function enable-remote-desktop {
  write-host "Do you wish to enable Remote Desktop capabilities? (y/n):" -foregroundColor "yellow" -noNewline
  [string]$Remote = Read-Host
  if ($Remote -eq "y" -or $Remote -eq "yes") {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
  }
}

# Reboot Function
function reset-computer {
  write-host "Some changes will only take effect after reboot, do you want to reboot right now? (y/n): " -foregroundColor "yellow" -noNewline
  [string]$Reboot = Read-Host
  if ($Reboot -eq "y" -or $Reboot -eq "yes") {
    Restart-Computer -Force
    Exit
  }
}

# Function runners
disableNetAdapterPowerSaving
disableUsbHubPowerSaving
enable-remote-desktop

# Now reboot
reboot-computer

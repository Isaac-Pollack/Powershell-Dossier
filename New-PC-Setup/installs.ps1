# Upgrade Chocolatey
choco upgrade -y chocolatey

# Base
choco install -y googlechrome
choco install -y firefox-dev --pre #I personally enjoy Dev Ed
choco install -y notepadplusplus
choco install -y 7zip
choco install -y paint.net
choco install -y spotify
choco install -y discord
choco install -y pnggauntlet
choco install -y notion
choco install -y paint.net
choco install -y qbittorrent
choco install -y greenshot

# Dev
choco install -y git
choco install -y git-lfs
choco install -y putty.portable
choco install -y winscp.portable
choco install -y python
choco install -y vcredist140
choco install -y gitkraken
choco install -y nodejs
choco install -y yarn
choco install -y golang
choco install -y visualstudiocode

# Jetbrains Products
choco install -y jetbrainstoolbox
choco install -y pycharm # Professional edition
choco install -y clion-ide

# Gaming
choco install -y steam-client
choco install -y battle.net
#choco install -y goggalaxy

# CLI
choco install -y curl

# Drivers / PNP Devices / System & Overclocking
$pnp = Get-PnpDevice | Select-Object 'FriendlyName'
if ( $pnp -match 'nvidia' ) { choco install -y geforce-experience }
if ( $pnp -match 'Ryzen' ) { choco install -y amd-ryzen-chipset }
if ( $pnp -match "Intel(R) Core(TM)" ) { choco install -y intel-xtu intel-dsa }
if ( $pnp -match 'NZXT' ) { choco install -y nzxt-cam }
choco install -y gpu-z
choco install -y cpu-z
choco install -y msiafterburner
choco install -y sysinternals
choco install -y speccy

# System Tweaks
## Disable Sticky Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506" -Verbose
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Type String -Value "58" -Verbose

## Configure windows display settings
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

# Functions
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

function reboot-computer {
  write-host "Some changes will only take effect after reboot, do you want to reboot right now? (y/n): " -foregroundColor "yellow" -noNewline
  [string]$Reboot = Read-Host
  if ($Reboot -eq "y" -or $Reboot -eq "yes") {
    Restart-Computer -Force
    Exit
  }
}

function enable-remote-desktop {
  write-host "Do you wish to enable Remote Desktop capabilities? (y/n):" -foregroundColor "yellow" -noNewline
  [string]$Remote = Read-Host
  if ($Remote -eq "y" -or $Remote -eq "yes") {
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
  }
}

# Run said functions
disableNetAdapterPowerSaving
disableUsbHubPowerSaving
enable-remote-desktop

# Set ExecutionPolicy back to Restricted once script is complete
Set-ExecutionPolicy Restricted

write-host ""
write-host "[ExecutionPolicy set back to restricted.]" -foregroundcolor "green"
write-host ""
write-host "[Setup completed!]" -foregroundcolor "green"

reboot-computer
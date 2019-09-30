# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


Write-Output  "Creating working directories structure..."

New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\gits" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\scripts" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\utils" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\virtualmachines" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\dockerhd" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\temp" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\dotfiles" | Out-Null

Write-Output  "Directories already created..."
Start-Sleep -s 5

Write-Output  "Executing Install script..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/valdecircarvalho/windows-setup/master/script-install.ps1'))

Start-Sleep -s 5

Write-Output  "Executing Customization script..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/valdecircarvalho/windows-setup/master/customizations.ps1'))

Start-Sleep -s 5

Write-Output  "Executing Disable Windows Features script..."
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/valdecircarvalho/windows-setup/master/disable-windows-features.ps1'))

Start-Sleep -s 5
#Reboot

Write-Output  "Restarting computer..."

Read-Host -Prompt "Configuration is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer

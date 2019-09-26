# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


write-host "Creating working directories structure..."

New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\gits" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\scripts" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\utils" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\virtualmachines" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\dockerhd" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\temp" | Out-Null
New-Item -ItemType "directory" -Path "$env:USERPROFILE\Documents\workdir\dotfiles" | Out-Null

write-host "Directories already created..."

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/valdecircarvalho/windows-setup/master/script-install.ps1'))

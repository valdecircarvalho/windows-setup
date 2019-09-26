# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


# Rename computer
$computerName = Read-Host 'Enter New Computer Name'
Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
Rename-Computer -NewName $computerName

#avoid sleep
Powercfg /Change monitor-timeout-ac 20
Powercfg /Change standby-timeout-ac 0

# add this pc to desktop

$thisPCIconRegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$thisPCRegValname = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
$item = Get-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -ErrorAction SilentlyContinue

if ($item) {
Set-ItemProperty  -Path $thisPCIconRegPath -name $thisPCRegValname -Value 0  
}

else {
New-ItemProperty -Path $thisPCIconRegPath -Name $thisPCRegValname -Value 0 -PropertyType DWORD  | Out-Null  
}

# Enable developer mode
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Enable remote desktop
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\" -Name "UserAuthentication" -Value 1
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

#Install Cholatey

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#InstallPagadges

write-host "Installing softwares with Cholatey..."

# Core 
choco install chocolateygui
choco install chocolatey-core.extension

## Browsers
choco install googlechrome
choco install firefox

# Tools
choco install 7zip.install
choco install notepadplusplus.install
choco install greenshot

# Sysadmin Tools
choco install putty.install

choco install curl
choco install wget
choco install jq

choco install winscp
choco install sysinternals
choco install cmder
choco install poshgit

# DevTools
choco install vscode
choco install postman


# DevOps 
choco install git-lfs
choco install git.install
choco install gitextensions
choco install awscli
choco install azure-cli
#choco install puppet-agent
choco install kubernetes-cli
choco install terraform
choco install packer
choco install consul
choco install vault
choco install powershell-core
choco install azurepowershell

choco install virtualbox

# Multimedia

choco install vlc

# Messengers
choco install slack
choco install telegram.install

choco install googledrive
choco install zoom
choco install lastpass
choco install mobaxterm
choco install whatsapp
choco install rsat
choco install etcher
choco install filezilla.server
choco install nano
choco install vmware-powercli-psmodule
choco install github-desktop
choco install hyper
choco install microsoft-windows-terminal
choco install awstools.powershell
choco install teracopy
choco install veeam-endpoint-backup-free
choco install rvtools
choco install chocolateyexplorer
choco install wsl
choco install packer
choco install terraform





#Reboot
Read-Host -Prompt "Configuration is done, restart is needed, press [ENTER] to restart computer."
## Restart-Computer


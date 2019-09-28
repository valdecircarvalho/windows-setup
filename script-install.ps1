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

$applist = @(
"chocolateygui",
"chocolatey-core.extension",
"googlechrome",
"firefox",
"7zip.install",
"notepadplusplus.install",
"greenshot",
"putty.install",
"curl",
"wget",
"jq",
"winscp",
"sysinternals",
"cmder",
"poshgit",
"vscode",
"postman",
"git-lfs",
"git.install",
"gitextensions",
"awscli",
"azure-cli",
"kubernetes-cli",
"terraform",
"packer",
"consul",
"vault",
"powershell-core",
"azurepowershell",
"virtualbox",
"vlc",
"slack",
"telegram.install",
"googledrive",
"zoom",
"lastpass",
"mobaxterm",
"whatsapp",
"rsat",
"etcher",
"filezilla.server",
"nano",
"vmware-powercli-psmodule",
"github-desktop",
"hyper",
"microsoft-windows-terminal",
"awstools.powershell",
"teracopy",
"veeam-endpoint-backup-free",
"rvtools",
"chocolateyexplorer",
"wsl",
"packer",
"terraform"

)

foreach($app in $applist) {

write-host "Installing"  $app "..."
Start-Sleep -s 1
write-host "choco install"  $app  "-y" 
Start-Sleep -s 1
}


#Reboot
Read-Host -Prompt "Configuration is done, restart is needed, press [ENTER] to restart computer."
## Restart-Computer


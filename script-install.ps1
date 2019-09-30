# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }



#Install Cholatey

## Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Refreshing environment variables. If rest of the scritp fails, restart elevated shell and rerun script."
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

Write-Output "Installing Scoop..."
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    scoop bucket add extras https://github.com/lukesampson/scoop-extras.git
    
Write-Output "Installing Boxstarter..."

    iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); Get-Boxstarter -Force
    Import-Module Boxstarter.Chocolatey


#InstallPagadges
write-output "Installing softwares with Cholatey..."

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
"git",
"github-desktop",
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
"terraform",
"python"
"docker-for-windows",
"python",
"vcredist2015",
"slack",
"telegram",
"whatsapp",
"zoom",

)
foreach($app in $applist) {

Write-Output  "Installing"  $app "..."
Start-Sleep -s 1
choco install $app -y --acceptlicense --force --no-progress --log-file="$env:USERPROFILE\Documents\workdir\temp\choco-install.log"
Start-Sleep -s 1
}

# Update pip
python -m pip install --upgrade pip

choco install -y Microsoft-Hyper-V-All --source="'windowsFeatures'"
choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"

Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv


#--- Ubuntu ---
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
# run the distro once and have it install locally with root user, unset password

RefreshEnv
Ubuntu1804 install --root
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y




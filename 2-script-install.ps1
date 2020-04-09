# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }



#Install Cholatey

## Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Refreshing environment variables. If rest of the scritp fails, restart elevated shell and rerun script."
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

#Write-Output "Installing Scoop..."
#    Set-ExecutionPolicy Bypass -Scope Process -Force; iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
#    scoop bucket add extras https://github.com/lukesampson/scoop-extras.git
    
#Write-Output "Installing Boxstarter..."
#    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1')); Get-Boxstarter -Force
#    Import-Module Boxstarter.Chocolatey


#InstallPagadges
write-output "Installing softwares with Cholatey..."

$applist = @(
"chocolateygui",
"chocolatey-core.extension",
"chocolatey-dotnetfx.extension",
"chocolatey-fastanswers.extension",
"chocolatey-windowsupdate.extension",
"googlechrome",
"microsoft-edge",
"7zip.install",
"notepadplusplus.install",
"poshgit",
"vscode",
"git-lfs",
"git",
"gitextensions",
"git",
"curl",
"teracopy",
#"DotNet4.5",
#"DotNet4.5.2",
#"DotNet4.6.1",
#"dotnet4.7.2",
#"dotnetfx",
#"KB2670838",
#"KB2919355",
#"KB2919442",
#"KB2999226",
#"KB3033929",
#"KB3035131",
"vcredist140",
"vcredist2010",
"vcredist2015"
)


foreach($app in $applist) {

Write-Output  "Installing"  $app "..."
Start-Sleep -s 1
choco install $app -y --acceptlicense --force --no-progress --log-file="$env:USERPROFILE\Documents\workdir\temp\choco-install.log"
RefreshEnv
Start-Sleep -s 1
}

RefreshEnv

$wf = @(
    "Containers",
    "HypervisorPlatform",
    "Microsoft-Windows-Subsystem-Linux",
    "VirtualMachinePlatform",
    "SimpleTCP",
    "Microsoft-Hyper-V-All",
    "Containers-DisposableClientVM",
    "Microsoft-Hyper-V-Tools-All",
    "Microsoft-Hyper-V",  
    "TelnetClient",
    "Windows-Defender-Default-Definitions",
    "Microsoft-Hyper-V-Management-PowerShell",
    "Microsoft-Hyper-V-Services",
    "Microsoft-Hyper-V-Hypervisor",      
    "Microsoft-Hyper-V-Management-Clients",
    "Windows-Defender-ApplicationGuard",
    "NFS-Administration",
    "ClientForNFS-Infrastructure",
    "ServicesForNFS-ClientOnly"
)

write-output "Installing Windows Features with Cholatey..."

foreach ($wf in $f) {
    Write-Output  "Installing"  $windowsfeature "..."
    Start-Sleep -s 1
    Enable-WindowsOptionalFeature -Online -FeatureName $wf -All
    RefreshEnv
    Start-Sleep -s 1
}


<# #--- Ubuntu ---
Write-Output  "Installing Ubuntu on WSL..."
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
# run the distro once and have it install locally with root user, unset password

RefreshEnv
Ubuntu1804 install --root
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y #>

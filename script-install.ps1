# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }



#Install Cholatey

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Output "Installing chocolatey"
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Refreshing environment variables. If rest of the scritp fails, restart elevated shell and rerun script."
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    scoop bucket add extras https://github.com/lukesampson/scoop-extras.git
    

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
"git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"",
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
"python",
)

foreach($app in $applist) {

write-host "Installing"  $app "..."
Start-Sleep -s 1
choco install $app -y 
Start-Sleep -s 1
}

Enable-WindowsOptionalFeature -Online -FeatureName containers -All
RefreshEnv
choco install -y docker-for-windows
choco install -y vscode-docker

choco install -y Microsoft-Hyper-V-All --source="'windowsFeatures'"
# Install python
choco install -y python --version=3.5.4

# Refresh path
refreshenv

# Update pip
python -m pip install --upgrade pip

# Install ML related python packages through pip
pip install numpy
pip install scipy
pip install pandas
pip install matplotlib
pip install tensorflow
pip install keras

# Get Visual Studio C++ Redistributables
choco install -y vcredist2015

choco install -y Microsoft-Windows-Subsystem-Linux --source="'windowsfeatures'"

#--- Ubuntu ---
# TODO: Move this to choco install once --root is included in that package
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
# run the distro once and have it install locally with root user, unset password

RefreshEnv
Ubuntu1804 install --root
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y

#Reboot
Read-Host -Prompt "Configuration is done, restart is needed, press [ENTER] to restart computer."
## Restart-Computer


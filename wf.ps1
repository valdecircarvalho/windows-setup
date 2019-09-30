# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

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

foreach ($wf in $f) {
    Write-Output  "Installing"  $windowsfeature "..."
    Start-Sleep -s 1
    Enable-WindowsOptionalFeature -Online -FeatureName $wf -All
    RefreshEnv
    Start-Sleep -s 1
}


Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All
Enable-WindowsOptionalFeature -Online -FeatureName SimpleTCP -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All
Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
Enable-WindowsOptionalFeature -Online -FeatureName TelnetClient -All
Enable-WindowsOptionalFeature -Online -FeatureName Windows-Defender-Default-Definitions -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Services -All
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor    -All  
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-Clients -All
Enable-WindowsOptionalFeature -Online -FeatureName Windows-Defender-ApplicationGuard -All
Enable-WindowsOptionalFeature -Online -FeatureName NFS-Administration -All
Enable-WindowsOptionalFeature -Online -FeatureName ClientForNFS-Infrastructure -All
Enable-WindowsOptionalFeature -Online -FeatureName ServicesForNFS-ClientOnly -All
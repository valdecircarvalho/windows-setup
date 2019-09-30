# Selfelevate
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


Set-Service -Name "DiagTrack" -StartupType disabled
Set-Service -Name "dmwappushservice" -StartupType disabled


$applist = @("Microsoft.Windows.Cortana", 
"Microsoft.XboxGameCallableUI", 
"Windows.CBSPreview", 
"Microsoft.Wallet", 
"Microsoft.XboxGameOverlay", 
"AMZNMobileLLC.KindleforWindows8", 
"Microsoft.XboxSpeechToTextOverlay", 
"Microsoft.SkypeApp", 
"Microsoft.Xbox.TCUI", 
"Microsoft.Messaging", 
"Microsoft.XboxIdentityProvider", 
"Microsoft.XboxApp", 
"Microsoft.MicrosoftOfficeHub", 
"Microsoft.MicrosoftSolitaireCollection", 
"Microsoft.ZuneVideo", 
"Microsoft.BingWeather", 
"Microsoft.ZuneMusic", 
"Microsoft.People", 
"Microsoft.Getstarted", 
"Microsoft.Office.OneNote",  
"Microsoft.WindowsFeedbackHub", 
"Microsoft.MicrosoftStickyNotes", 
"Microsoft.XboxGamingOverlay")


foreach($app in $applist) {

    Write-Output  "Removing"  $app "..."
    Start-Sleep -s 1
    Get-AppxPackage $app | Remove-AppxPackage
    Start-Sleep -s 1
    }

# Get-WindowsOptionalFeature -Online | ? state -eq 'disabled' | select featurename | sort -Descending
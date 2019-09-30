Set-Service -Name "DiagTrack" -StartupType disabled
Set-Service -Name "dmwappushservice" -StartupType disabled

Get-AppxPackage flipboard | Remove-AppxPackage

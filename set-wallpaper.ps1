
#--- Set Wallpaper ---

$url = "https://github.com/valdecircarvalho/windows-setup/raw/master/wallpaper/U2OSwco.jpg"
$webclient = New-Object System.Net.WebClient
$filepath = "c:\temp\wallpaper.jpg"
$webclient.DownloadFile($url,$filepath)

write-host $filepath

Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value c:\temp\wallpaper.jpg
rundll32.exe user32.dll, UpdatePerUserSystemParameters


$SteamExeFilePath = "C:\Program Files (x86)\Steam\steam.exe"
$Min = Read-Host -Prompt 'Start steam in how many minutes? '
echo "Set."

$Time = 60*[int]$Min
Start-Sleep -Seconds $Time
Start-Process -FilePath  $SteamExeFilePath
echo "Done."
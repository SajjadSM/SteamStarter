$SteamExeFilePath = "C:\Program Files (x86)\Steam\steam.exe"
$DefaultStartTime = "01:00"
$DefaultShutDownTime = "08:00"

$TestPathResult = Test-Path $SteamExeFilePath
if ($TestPathResult -eq $false){
    echo "Steam.exe file could not be found."
    Write-Host -NoNewLine 'Press any key to exit...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    Exit
}

$_startTimePrompt = "Start download at: (default: " + $DefaultStartTime + ")"
$StartTime = Read-Host -Prompt $_startTimePrompt
if ($StartTime.Length -eq 0) {
    $StartTime = $DefaultStartTime
}

$_ShutdownPrompt = "Do you want the computer to turn off? (y/n)"
$Shutdown = Read-Host -Prompt $_ShutdownPrompt
$ShutDownTime = ""
if ($Shutdown -eq "y"){
    $_shutDownTimePrompt = "Shot down computer at: (default: " + $DefaultShutDownTime + ")"
    $ShutDownTime = Read-Host -Prompt $_shutDownTimePrompt
    if ($ShutDownTime.Length -eq 0) {
        $ShutDownTime = $DefaultShutDownTime
    }
}
echo "Set... (Don't close this window)"

$CheckTime = $true
$SteamStarted = $false
do {
    $time_now = Get-Date -Format "HH:mm"
    # Check time for start
    if (($time_now -eq $StartTime) -and ($SteamStarted -eq $false)){
        Start-Process -FilePath  $SteamExeFilePath
        $SteamStarted = $true
    }

    # Check time for shut down
    if ($Shutdown -eq "y") {
        if ($time_now -eq $ShutDownTime){
            shutdown.exe /s
            Exit
        }
    } else {
        if ($SteamStarted){
            $CheckTime = $false
        }
    }
    Start-Sleep -Seconds 5
} while ($CheckTime)
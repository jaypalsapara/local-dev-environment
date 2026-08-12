param(
    [string]$Action
)

$redisPath = "$env:USERPROFILE\scoop\apps\redis\current"
$redisExe = "$redisPath\redis-server.exe"
$redisCli = "$redisPath\redis-cli.exe"

if ($Action -eq "--stop") {
    $process = Get-Process redis-server -ErrorAction SilentlyContinue

    if ($process) {

        & $redisCli SHUTDOWN

        Write-Host "Redis stopped."
        
    }
    else {

        Write-Host "Redis not running."

    }

}
else {
    
    if (Get-Process redis-server -ErrorAction SilentlyContinue) {
        Write-Host "Redis is already running."
    }
    else {
        Start-Process `
            -FilePath $redisExe `
            -WindowStyle Hidden

        Write-Host "Redis started."
    }
    
}

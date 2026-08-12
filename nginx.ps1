param(
    [string]$Action
)

$nginxPath = "$env:USERPROFILE\scoop\apps\nginx\current"
$nginxExe = "$nginxPath\nginx.exe"

# Stop nginx
if ($Action -eq "--stop") {
    $process = Get-Process mysqld -ErrorAction SilentlyContinue
    if ($process) {
        & $nginxExe -p "$nginxPath" -s quit

        Write-Host "Nginx stopped."
    }
    else {

        Write-Host "Nginx not running."
        
    }

    
}
# Start nginx
else {
    if (Get-Process nginx -ErrorAction SilentlyContinue) {
        Write-Host "Nginx is already running."
    }
    else {
        Start-Process `
            -FilePath $nginxExe `
            -ArgumentList "-p `"$nginxPath`"" `
            -WorkingDirectory $nginxPath

        Write-Host "Nginx started."
    }
}
param(
    [string]$Version = 85
)

$Package = "php$Version"

$phpPath = "$env:USERPROFILE\scoop\apps\php$Version\current"
$phpCgi = "$phpPath\php-cgi.exe"

scoop install $Package *> $null

scoop reset $Package *> $null

Get-Process php-cgi -ErrorAction SilentlyContinue | Stop-Process -Force

Start-Process `
    -FilePath $phpCgi `
    -ArgumentList "-b 127.0.0.1:9000" `
    -WorkingDirectory $phpPath `
    -WindowStyle Hidden


Write-Host "php$Version switched"
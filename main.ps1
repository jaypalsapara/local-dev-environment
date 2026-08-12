param(
    [string]$Action,
    [int]$php = 85
)

if ($Action -eq "--stop") {
    # Stop services
    & "$PSScriptRoot\nginx.ps1" --stop
    & "$PSScriptRoot\mysql.ps1" --stop
    & "$PSScriptRoot\redis.ps1" --stop
}
else {
    # Start services
    & "$PSScriptRoot\nginx.ps1"
    & "$PSScriptRoot\php.ps1" -Version $php
    & "$PSScriptRoot\mysql.ps1"
    & "$PSScriptRoot\redis.ps1"
}
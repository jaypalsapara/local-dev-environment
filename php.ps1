param(
    [string]$Version = 85
)

$Package = "php$Version"

scoop install $Package *> $null

scoop reset $Package *> $null

Write-Host "php$Version switched"
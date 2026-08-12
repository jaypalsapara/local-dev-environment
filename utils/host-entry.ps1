param(
    [string]$Action,
    [string]$Domain
) 

$HostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

function Add-HostEntry {
    param(
        [string]$HostName
    )

    $IPv4Entry = "127.0.0.1`t$HostName"
    $IPv6Entry = "::1`t$HostName"

    $Content = Get-Content $HostsFile -ErrorAction Stop

    # IPv4
    $IPv4Exists = $Content | Where-Object {
        $_ -match "^\s*127\.0\.0\.1\s+$([regex]::Escape($HostName))\s*$"
    }

    if (-not $IPv4Exists) {
        Add-Content -Path $HostsFile -Value $IPv4Entry
        Write-Host "Added IPv4 to hosts: $HostName" -ForegroundColor Green
    }
    else {
        Write-Host "IPv4 already exists: $HostName" -ForegroundColor Yellow
    }

    # IPv6
    $IPv6Exists = $Content | Where-Object {
        $_ -match "^\s*::1\s+$([regex]::Escape($HostName))\s*$"
    }

    if (-not $IPv6Exists) {
        Add-Content -Path $HostsFile -Value $IPv6Entry
        Write-Host "Added IPv6 to hosts: $HostName" -ForegroundColor Green
    }
    else {
        Write-Host "IPv6 already exists: $HostName" -ForegroundColor Yellow
    }
}

function Remove-HostEntry {
    param(
        [string]$HostName
    )

    $Content = Get-Content $HostsFile -ErrorAction Stop

    $NewContent = $Content | Where-Object {
        $_ -notmatch "^\s*127\.0\.0\.1\s+$([regex]::Escape($HostName))\s*$" -and
        $_ -notmatch "^\s*::1\s+$([regex]::Escape($HostName))\s*$"
    }

    Set-Content -Path $HostsFile -Value $NewContent

    Write-Host "Removed IPv4 and IPv6 from hosts: $HostName" -ForegroundColor Green
}

if ($Action -eq '--add') {
    Add-HostEntry -HostName "$Domain.test"

}
elseif ($Action -eq '--remove') {
    Remove-HostEntry -HostName "$Domain.test"
}

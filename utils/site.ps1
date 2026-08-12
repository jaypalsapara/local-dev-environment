param(
    [string]$Action,
    [string]$Domain = "invoice-app"
)

$ErrorActionPreference = "Stop"

$TemplateFile = "$PSScriptRoot\..\templates\nginx.template.conf"
$HostEntryProcess = "$PSScriptRoot\host-entry.ps1"
$CAProcess = "$PSScriptRoot\ca.ps1"

$NginxConfDir = "$env:USERPROFILE\scoop\apps\nginx\current\conf\sites-enabled"
$OutputFile = "$NginxConfDir\$Domain.conf"
$Username = $env:USERNAME

if ($Action -eq "--add") {
    # Check template
    if (-not (Test-Path $TemplateFile)) {
        Write-Host "Template not found: $TemplateFile" -ForegroundColor Red
        exit 1
    }

    # Create conf directory
    if (-not (Test-Path $NginxConfDir)) {
        New-Item -ItemType Directory -Path $NginxConfDir -Force | Out-Null
    }

    # Read template
    $Config = Get-Content $TemplateFile -Raw

    # Replace placeholders
    $Config = $Config.Replace("{{domain}}", $Domain)
    $Config = $Config.Replace("{{username}}", $Username)

    # Write nginx config
    [System.IO.File]::WriteAllText(
        $OutputFile,
        $Config,
        [System.Text.UTF8Encoding]::new($false)
    )

    Write-Host ""
    Write-Host "Nginx configuration created successfully." -ForegroundColor Green

    # Add host entry
    & $HostEntryProcess --add -Domain $Domain

    # Add CA
    & $CAProcess --add -Domain $Domain


    Write-Host ""
    Write-Host "Domain : $Domain.test"
    Write-Host "Config : $OutputFile"
    

}
elseif ($Action -eq "--remove") {


    if (Test-Path $OutputFile) {

        Remove-Item $OutputFile
    }

    # Remove host entry
    & $HostEntryProcess --remove -Domain $Domain

    # Remove CA files
    & $CAProcess --remove -Domain $Domain

    Write-Host "Removed $Domain.test"
}
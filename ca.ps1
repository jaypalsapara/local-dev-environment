param (
    [string]$Action,
    [string]$Name
)

# Create and install a local CA
mkcert -install

# Create certificate for *.test and localhost
mkdir "$env:USERPROFILE\.certs" -Force

$CertFile = "$env:USERPROFILE\.certs\$Name.crt"
$KeyFile = "$env:USERPROFILE\.certs\$Name.key"

if ($Action -eq '--add') {
    mkcert `
        -key-file $CertFile `
        -cert-file $KeyFile `
        "$Name.test"

    Write-Host "Added certificate: $CertFile"
    Write-Host "Added private key: $KeyFile"

}
elseif ($Action -eq '--remove') {

    if (Test-Path $CertFile) {
        Remove-Item $CertFile -Force
        Write-Host "Removed certificate: $CertFile"
    }

    if (Test-Path $KeyFile) {
        Remove-Item $KeyFile -Force
        Write-Host "Removed private key: $KeyFile"
    }
}

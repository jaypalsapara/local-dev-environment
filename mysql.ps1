param(
    [string]$Action
)

$mysqlPath = "$env:USERPROFILE\scoop\apps\mysql\current\bin"
$mysqlExe = "$mysqlPath\mysqld.exe"
$mysqlAdminExe = "$mysqlPath\mysqladmin.exe"

# Stop mysql
if ($Action -eq "--stop") {

    $mysqlProcess = Get-Process mysqld -ErrorAction SilentlyContinue

    if ($mysqlProcess) {

        & $mysqlAdminExe -u root shutdown

        $mysqlProcess | Wait-Process -Timeout 10 -ErrorAction SilentlyContinue

        if (Get-Process mysqld -ErrorAction SilentlyContinue) {
            Write-Host "MySQL did not shut down gracefully. Force stopping..."

            Stop-Process -Name mysqld -Force

            Write-Host "MySQL force stopped."
        }
        else {
            Write-Host "MySQL stopped."
        }
    }
    else {
        Write-Host "MySQL not running."
    }
}
# Start mysql
else {
    if (Get-Process mysqld -ErrorAction SilentlyContinue) {
        Write-Host "Mysql is already running."
    }
    else {
        Start-Process `
            -FilePath $mysqlExe `
            -ArgumentList "--standalone" `
            -WorkingDirectory $mysqlPath `
            -WindowStyle Hidden

        Write-Host "Mysql started."
    }
}
# Install scoop
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop is installed."
}
else {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# Add scoop buckets
scoop bucket add main
scoop bucket add versions
scoop bucket add extras

# Install packages
scoop install "main/nginx"
scoop install "versions/php85"
scoop install "main/mysql"
scoop install "main/composer"
scoop install "versions/nodejs24"
scoop install "main/redis"
scoop install "extras/mkcert"
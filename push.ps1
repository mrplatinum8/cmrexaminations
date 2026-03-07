# Auto-sync HTML files from root to public/ and push to GitHub
param(
    [string]$Message = "update"
)

Write-Host "Syncing HTML files to public/..." -ForegroundColor Cyan

# Copy all HTML files from root to public/
Get-ChildItem -Path $PSScriptRoot -Filter "*.html" | ForEach-Object {
    Copy-Item $_.FullName "$PSScriptRoot\public\$($_.Name)" -Force
    Write-Host "  Copied: $($_.Name)" -ForegroundColor Green
}

Write-Host "Committing and pushing..." -ForegroundColor Cyan

git -C $PSScriptRoot add .
git -C $PSScriptRoot commit -m $Message
git -C $PSScriptRoot push origin main

Write-Host "Done! Changes are live on Vercel." -ForegroundColor Green

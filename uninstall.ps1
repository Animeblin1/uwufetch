# UwU Fetch Uninstaller for PowerShell
# https://github.com/Animeblin1/uwufetch

Write-Host "`n💔 Uninstalling UwU Fetch... goodbye onii-chan~ 💔`n" -ForegroundColor Magenta

$fetchDir = "C:\fetch"
$scriptPath = "$fetchDir\uwu_fetch.ps1"
$removed = $false

if (Test-Path $PROFILE) {
    Write-Host "Removing from PowerShell profile..." -ForegroundColor Yellow
    
    $profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
    
    if ($profileContent) {
        $originalLength = $profileContent.Length
        
        $profileContent = $profileContent -replace '[\r\n]*\. "C:\\fetch\\uwu_fetch\.ps1"[\r\n]*', ''
        $profileContent = $profileContent -replace '[\r\n]*function uwufetch \{ & "C:\\fetch\\uwu_fetch\.ps1" \}[\r\n]*', ''
        $profileContent = $profileContent.Trim()
        
        if ($profileContent.Length -ne $originalLength) {
            Set-Content $PROFILE -Value $profileContent
            Write-Host "✓ Removed UwU Fetch from profile" -ForegroundColor Green
            $removed = $true
        } else {
            Write-Host "✓ Nothing to remove from profile" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "✓ Profile not found, nothing to clean" -ForegroundColor Yellow
}

if (Test-Path $fetchDir) {
    Write-Host "`nDeleting $fetchDir..." -ForegroundColor Yellow
    try {
        Remove-Item $fetchDir -Recurse -Force
        Write-Host "✓ Deleted $fetchDir" -ForegroundColor Green
        $removed = $true
    } catch {
        Write-Host "✗ Failed to delete $fetchDir" -ForegroundColor Red
        Write-Host "  Error: $_" -ForegroundColor Yellow
        Write-Host "  You can manually delete it with:" -ForegroundColor Cyan
        Write-Host "  Remove-Item C:\fetch -Recurse -Force" -ForegroundColor Gray
    }
} else {
    Write-Host "✓ Directory $fetchDir not found" -ForegroundColor Yellow
}

if (Get-Command uwufetch -ErrorAction SilentlyContinue) {
    Write-Host "`n⚠ uwufetch command is still loaded in current session" -ForegroundColor Yellow
    Write-Host "  Restart PowerShell to fully remove it" -ForegroundColor Cyan
}

Write-Host "`n╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
if ($removed) {
    Write-Host "║  😢 Uninstall complete... sayonara~ 😢           ║" -ForegroundColor Cyan
} else {
    Write-Host "║  ✓ Nothing was found to uninstall               ║" -ForegroundColor Cyan
}
Write-Host "╠══════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  UwU Fetch has been removed from your system.    ║" -ForegroundColor White
Write-Host "║                                                  ║" -ForegroundColor White
Write-Host "║  To reinstall anytime:                           ║" -ForegroundColor Yellow
Write-Host "║    irm https://raw.githubusercontent.com/        ║" -ForegroundColor Green
Write-Host "║    Animeblin1/uwufetch/main/install.ps1 | iex    ║" -ForegroundColor Green
Write-Host "║                                                  ║" -ForegroundColor White
Write-Host "║  Thank you for using UwU Fetch! >w<              ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

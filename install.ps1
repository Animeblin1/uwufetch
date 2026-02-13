# UwU Fetch Installer for PowerShell
# https://github.com/Animeblin1/uwufetch

Write-Host "`n✨ Installing UwU Fetch... nyaa~ ✨`n" -ForegroundColor Magenta

$psVersion = $PSVersionTable.PSVersion.Major
if ($psVersion -lt 7) {
    Write-Host "⚠ PowerShell $psVersion detected. PowerShell 7+ is required!" -ForegroundColor Red
    Write-Host "`nInstalling PowerShell 7 via winget...`n" -ForegroundColor Yellow
    
    try {
        winget install --id Microsoft.PowerShell --source winget --silent --accept-package-agreements --accept-source-agreements
        Write-Host "`n✓ PowerShell 7 installed successfully!" -ForegroundColor Green
        Write-Host "`nPlease restart your terminal and run this installer again in PowerShell 7 (pwsh)" -ForegroundColor Cyan
        Write-Host "You can launch it by typing: pwsh`n" -ForegroundColor Yellow
        exit
    } catch {
        Write-Host "✗ Failed to install PowerShell 7 via winget" -ForegroundColor Red
        Write-Host "Please install manually from: https://aka.ms/powershell`n" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "✓ PowerShell $psVersion detected" -ForegroundColor Green

$fetchDir = "C:\fetch"
if (!(Test-Path $fetchDir)) {
    New-Item -Path $fetchDir -ItemType Directory -Force | Out-Null
    Write-Host "✓ Created directory $fetchDir" -ForegroundColor Green
} else {
    Write-Host "✓ Directory $fetchDir already exists" -ForegroundColor Yellow
}

$scriptPath = "$fetchDir\uwu_fetch.ps1"

$scriptContent = @'
Write-Host ""

$artLines = @(
    "  ██╗   ██╗  ██╗    ██╗  ██╗   ██╗"
    "  ██║   ██║  ██║    ██║  ██║   ██║"
    "  ██║   ██║  ██║ █╗ ██║  ██║   ██║"
    "  ██║   ██║  ██║███╗██║  ██║   ██║"
    "  ╚██████╔╝  ╚███╔███╔╝  ╚██████╔╝"
    "   ╚═════╝    ╚══╝╚══╝    ╚═════╝"
)

foreach ($line in $artLines) {
    Write-Host $line -ForegroundColor Magenta
}

Write-Host ""

$width = [console]::WindowWidth
$os = Get-CimInstance Win32_OperatingSystem
$uptime = (Get-Date) - $os.LastBootUpTime
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$gpu = Get-CimInstance Win32_VideoController | Select-Object -First 1
$mb = Get-CimInstance Win32_BaseBoard | Select-Object -First 1
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$mem = $os

$totalMem = [math]::Round($mem.TotalVisibleMemorySize/1MB,1)
$usedMem = [math]::Round(($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory)/1MB,1)
$memPercent = [math]::Round($usedMem / $totalMem * 100,1)

$usedDisk = [math]::Round(($disk.Size - $disk.FreeSpace)/1GB,1)
$totalDisk = [math]::Round($disk.Size/1GB,1)
$diskPercent = [math]::Round(($disk.Size - $disk.FreeSpace)/$disk.Size*100,1)

$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notmatch "vEthernet|Loopback|Virtual"} | Select-Object -First 1).IPAddress
$userName = $env:USERNAME
$hostName = $env:COMPUTERNAME

Write-Host ""

$infoLines = @(
    "$userName-chan~ ~ 🌸 $hostName"
    "-------------------------"
    "OS: $($os.Caption)"
    "Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes"
    "Local IP: $ip"
    "Motherboard: $($mb.Manufacturer) $($mb.Product)"
    "CPU: $($cpu.Name)"
    "GPU: $($gpu.Name)"
    "Memory: $usedMem GiB / $totalMem GiB ($memPercent%)"
    "Disk (C:): $usedDisk GiB / $totalDisk GiB ($diskPercent%)"
)

foreach ($line in $infoLines) {
    Write-Host $line.PadLeft($width) -ForegroundColor Cyan
}

$phrases = @(
    "mrrraw... sowwy my owneeeew... i ate $usedMem/$totalMem GiB of wam... f-forgive me? 👉👈 🥺"
    "oh nwo! itw foo aww 🥀..."
    "~>w<~ pwease notice me! 👉👈"
    "nyaa~ i'm weady for commands! >///<"
    "h-haii~ *giggles* what's nwext? uwu"
    "*blushes* h-hewlo there~"
    "goodie goodie~ let's code! owo"
    "yayyy~ time for fun! ^w^"
    "hewwo~ w-what shouwd we dwo today? >w<"
    "✨ nya~ nya~ everything is kawaii uwu"
)

Write-Host ""
Write-Host ($phrases | Get-Random) -ForegroundColor Magenta
Write-Host ""
'@

Set-Content -Path $scriptPath -Value $scriptContent -Encoding UTF8
Write-Host "✓ Created script $scriptPath" -ForegroundColor Green

$policy = Get-ExecutionPolicy -Scope CurrentUser
if ($policy -eq 'Restricted' -or $policy -eq 'Undefined') {
    Write-Host "`n⚠ Current execution policy: $policy" -ForegroundColor Yellow
    Write-Host "Setting execution policy to RemoteSigned..." -ForegroundColor Cyan
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Write-Host "✓ ExecutionPolicy set to RemoteSigned" -ForegroundColor Green
    } catch {
        Write-Host "✗ Failed to change policy. Run PowerShell as admin and execute:" -ForegroundColor Red
        Write-Host "  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Yellow
    }
} else {
    Write-Host "✓ ExecutionPolicy already allows scripts ($policy)" -ForegroundColor Green
}

if (!(Test-Path $PROFILE)) {
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
    Write-Host "✓ Created profile $PROFILE" -ForegroundColor Green
}

$profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
$autoloadLine = '. "C:\fetch\uwu_fetch.ps1"'
$aliasLine = 'function uwufetch { & "C:\fetch\uwu_fetch.ps1" }'

if ($profileContent -notmatch [regex]::Escape($autoloadLine)) {
    Add-Content -Path $PROFILE -Value "`n$autoloadLine"
    Write-Host "✓ Added autoload to profile" -ForegroundColor Green
} else {
    Write-Host "✓ Autoload already exists in profile" -ForegroundColor Yellow
}

if ($profileContent -notmatch [regex]::Escape($aliasLine)) {
    Add-Content -Path $PROFILE -Value $aliasLine
    Write-Host "✓ Added 'uwufetch' alias" -ForegroundColor Green
} else {
    Write-Host "✓ Alias 'uwufetch' already exists" -ForegroundColor Yellow
}

Write-Host "`n✨ Applying changes... ✨`n" -ForegroundColor Magenta
. $PROFILE

Write-Host "`n╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🎉 Installation complete! nyaa~ >w<             ║" -ForegroundColor Cyan
Write-Host "╠══════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  UwU Fetch will now show on every launch!        ║" -ForegroundColor White
Write-Host "║                                                  ║" -ForegroundColor White
Write-Host "║  Commands:                                       ║" -ForegroundColor Yellow
Write-Host "║    uwufetch  — run manually                      ║" -ForegroundColor Green
Write-Host "║                                                  ║" -ForegroundColor White
Write-Host "║  Script location:                                ║" -ForegroundColor Yellow
Write-Host "║    C:\fetch\uwu_fetch.ps1                        ║" -ForegroundColor Magenta
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

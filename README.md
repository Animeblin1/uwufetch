# 🌸 UwU Fetch for PowerShell

A kawaii system fetch script for PowerShell with ASCII art and cute phrases~

## ✨ Features

- 🎨 Beautiful UwU ASCII art
- 💖 Random cute phrases on every launch
- 📊 System information (OS, CPU, GPU, RAM, Disk, IP)
- 🚀 Auto-loads on PowerShell startup
- 🎯 One-command installation
- ✅ Auto-installs PowerShell 7 if needed

## 📦 Installation

### Quick Install

Open **PowerShell** (any version) and run:

```powershell
irm https://raw.githubusercontent.com/Animeblin1/uwufetch/main/install.ps1 | iex
```

> ⚡ If you don't have PowerShell 7, the installer will automatically install it via `winget`

### Manual Install

1. Download `install.ps1`
2. Run in PowerShell:

```powershell
.\install.ps1
```

## 🎮 Usage

UwU Fetch automatically runs on PowerShell startup.

To run manually:

```powershell
uwufetch
```

## 🗑️ Uninstall

### Quick Uninstall

```powershell
irm https://raw.githubusercontent.com/Animeblin1/uwufetch/main/uninstall.ps1 | iex
```

### Manual Uninstall

1. Download `uninstall.ps1`
2. Run in PowerShell:

```powershell
.\uninstall.ps1
```

### Manual Removal (without script)

Edit your PowerShell profile:

```powershell
notepad $PROFILE
```

Delete these lines and save:

```powershell
. "C:\fetch\uwu_fetch.ps1"
function uwufetch { & "C:\fetch\uwu_fetch.ps1" }
```

Then delete the folder:

```powershell
Remove-Item C:\fetch -Recurse -Force
```

## 📸 Preview

```
  ██╗   ██╗  ██╗    ██╗  ██╗   ██╗
  ██║   ██║  ██║    ██║  ██║   ██║
  ██║   ██║  ██║ █╗ ██║  ██║   ██║
  ██║   ██║  ██║███╗██║  ██║   ██║
  ╚██████╔╝  ╚███╔███╔╝  ╚██████╔╝
   ╚═════╝    ╚══╝╚══╝    ╚═════╝


                                user-chan~ ~ 🌸 DESKTOP-PC
                                         -------------------------
                                      OS: Windows 11 Pro
                    Uptime: 2 days, 5 hours, 13 minutes
                                    Local IP: 192.168.1.42
                       Motherboard: ASUS ROG STRIX B550-F
                            CPU: AMD Ryzen 7 5800X
                            GPU: NVIDIA GeForce RTX 3070
                 Memory: 12.3 GiB / 31.9 GiB (38.6%)
              Disk (C:): 234.1 GiB / 476.9 GiB (49.1%)

✨ nya~ nya~ everything is kawaii uwu
```

## 🛠️ Requirements

- **Windows 10/11**
- **PowerShell 7+** (auto-installed by installer if missing)
- **winget** (pre-installed on Windows 11, available on Windows 10 via [App Installer](https://apps.microsoft.com/detail/9nblggh4nns1))

### Optional Requirements

- **Internet connection** (for one-command install/uninstall)
- **Administrator rights** (only if execution policy needs to be changed)

## 📁 File Structure

```
C:\fetch\
└── uwu_fetch.ps1          # Main fetch script

Documents\PowerShell\
└── Microsoft.PowerShell_profile.ps1   # Profile with autoload (PS 7)
```

or

```
Documents\WindowsPowerShell\
└── Microsoft.PowerShell_profile.ps1   # Profile (PS 5.1)
```

## 🔧 Troubleshooting

### "uwufetch is not recognized" after installation

The function hasn't loaded yet. Reload your profile:

```powershell
. $PROFILE
```

Or restart PowerShell.

### Verify installation

Check if the script exists:

```powershell
Test-Path C:\fetch\uwu_fetch.ps1
```

Check if profile contains the function:

```powershell
Get-Content $PROFILE | Select-String "uwufetch"
```

Manually load the function:

```powershell
function uwufetch { & "C:\fetch\uwu_fetch.ps1" }
```

### PowerShell 7 not installing automatically

Install manually:

```powershell
winget install Microsoft.PowerShell
```

Or download from: https://aka.ms/powershell

### "Execution policy" error

Run as administrator:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Script not running on startup

Check if profile exists:

```powershell
Test-Path $PROFILE
Get-Content $PROFILE
```

Manually reload:

```powershell
. $PROFILE
```

### "winget not found" error

Install App Installer from Microsoft Store:
https://apps.microsoft.com/detail/9nblggh4nns1

## 🤝 Contributing

Contributions are welcome! Feel free to:

- 🐛 Report bugs
- 💡 Suggest new features
- 🎨 Improve ASCII art
- 📝 Fix documentation
- ✨ Add more kawaii phrases

## 📝 License

MIT License - feel free to use and modify!

## 💖 Credits

Made with love and >w<

Inspired by neofetch and other fetch tools~

---

⭐ **Star this repo if you like it!** ⭐

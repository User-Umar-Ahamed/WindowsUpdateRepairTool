# WindowsUpdateRepairTool
A powerful, menu-based automation tool designed to diagnose and fix common Windows Update problems. This script is written in **Batch (BAT)** language and intended for Windows users who want to troubleshoot update errors, repair corrupted files, or automate system maintenance tasks.

---

## 🧐 What Is This?

This is an **all-in-one tool** created to help Windows users:

- Repair Windows Update
- Clear update cache
- Fix stuck/failing updates
- Restart update services
- Update apps using Winget
- Run SFC and DISM health scans

All in a **simple and user-friendly menu**.

---

## 🔧 What Can It Do?

| Option | Description |
|--------|-------------|
| **1** | Full Windows Update Reset (recommended for major issues) |
| **2** | Run `sfc /scannow` and `DISM /RestoreHealth` system repairs |
| **3** | Delete Windows Update cache only (with `"Press Enter to continue"` warning) |
| **4** | Restart all update-related services (BITS, CryptSvc, etc.) |
| **5** | Fix retry/update loop issues and stuck components |
| **6** | Update all installed apps using [`winget`](https://learn.microsoft.com/en-us/windows/package-manager/winget/) |
| **0** | Exit the tool |

---

## ⚙️ How It Works

This script uses:

- ✅ `net stop / start` to manage services
- ✅ `rd /s /q` to remove problem folders like `SoftwareDistribution`
- ✅ `regsvr32` to reset update DLLs
- ✅ `DISM` and `SFC` to repair system integrity
- ✅ `winget` to check and upgrade apps

It's written in **Windows Batch (.bat)** — a command-line scripting language built into all versions of Windows.

---

## 🖥️ Requirements

- Works on **Windows 10, 11**
- Must be run as **Administrator**
- Optional: `winget` installed (for Option 6)
- Safe to use: Does NOT modify your personal files

---

## ▶️ How to Use

1. Download the `.bat` file from this repo
2. Right-click → `Run as Administrator`
3. Pick a number from the menu
4. Follow the prompts
5. Restart your PC for the best results

---

## 🛡️ Why Use This Tool?

- No need to remember complex DISM, SFC, or DLL reset commands
- Helps restore broken Windows Update without reinstalling Windows
- Saves time vs. long manual troubleshooting
- Completely open-source and hackable — edit it as you wish

---

## 🧑‍💻 Built By

**Umar Ahamed**  
Cybersecurity Student • Sri Lanka  
> Passionate about security automation, ethical hacking, and student empowerment

⭐ Connect via GitHub: https://github.com/User-Umar-Ahamed

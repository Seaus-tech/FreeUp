# 🧹 FreeUp - macOS Storage Optimizer

<p align="center">
  <strong>Clean your Mac, reclaim storage space, and boost performance with one click.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-macOS-blue?style=flat-square&logo=apple" alt="macOS" />
  <img src="https://img.shields.io/badge/Language-Swift-orange?style=flat-square&logo=swift" alt="Swift" />
  <img src="https://img.shields.io/badge/Framework-SwiftUI-orange?style=flat-square&logo=swift" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License" />
</p>

---

## 🌌 Overview

FreeUp is a modern macOS disk cleaner and system optimizer built with SwiftUI. It intelligently scans your Mac for unnecessary files and helps you reclaim valuable storage space with an intuitive, native interface.

---

## ✨ Features

- 🔍 **Smart Scan** — Finds user/system/app caches, logs, temp files, Xcode junk, and development tool caches
- 📊 **Space Lens** — Visual breakdown of what's taking up disk space
- ⚡ **Login Items** — View and manage apps that launch at startup
- 🛡️ **Launch Agents** — Inspect and remove suspicious background agents
- 🔒 **Privacy Traces** — Clear browsing and activity traces
- 📈 **Scan History** — Track how much space you've freed over time

---

## 📦 Requirements

- macOS 13.0 (Ventura) or later
- [Download the latest `.dmg`](dmgs/FreeUpformac.dmg)

---

## 🚀 Installation

1. Download the latest DMG from the releases
2. Open the downloaded file
3. Drag FreeUp to your Applications folder
4. Launch FreeUp and grant necessary permissions

---

## 🛠️ Development

### Building from Source

```bash
# Clone the repository
git clone https://github.com/Seaus-tech/FreeUp.git
cd FreeUp

# Open in Xcode
open FreeUp.xcodeproj
```

### Permissions Required

FreeUp requires Full Disk Access to scan system locations. You can grant this in:
`System Preferences > Privacy & Security > Full Disk Access`

---

## 📂 Repository Structure

```
FreeUp/
├── Sources/              # Main application source code
├── Resources/            # Assets and resources
├── dmgs/                 # DMG distribution files
└── README.md             # This file
```

---

## ⚠️ Safety Notice

FreeUp only removes files that are safe to delete. System-critical files are never targeted. Always review files before deleting.

---

<p align="center">
  <sub>© 2026 Seaus Tech. All rights reserved.</sub>
</p>
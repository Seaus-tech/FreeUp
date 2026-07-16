# 🧹 FreeUp - macOS Storage Optimizer

<p align="center>
  <strong>Clean your Mac, reclaim storage space, and boost performance with one click.</strong>
</p>

<p align="center>
  <img src="https://img.shields.io/badge/Platform-macOS-blue?style=flat-square&logo=apple" alt="macOS" />
  <img src="https://img.shields.io/badge/Language-Swift-F54A46?style=flat-square&logo=swift" alt="Swift" />
  <img src="https://img.shields.io/badge/Framework-SwiftUI-F54A46?style=flat-square&logo=swift" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="License" />
</p>

---

## 📖 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Permissions](#permissions)
- [Development](#development)
- [Repository Structure](#repository-structure)
- [Roadmap](#roadmap)
- [Safety Notice](#safety-notice)

## Overview

FreeUp is a modern macOS disk cleaner and system optimizer built with SwiftUI. It intelligently scans your Mac for unnecessary files and helps you reclaim valuable storage space with an intuitive, native interface.

## Features

| Feature | Description |
|---------|-------------|
| 🔍 **Smart Scan** | Finds user/system/app caches, logs, temp files, Xcode junk, and development tool caches |
| 📊 **Space Lens** | Visual breakdown of what's taking up disk space |
| ⚡ **Login Items** | View and manage apps that launch at startup |
| 🛡️ **Launch Agents** | Inspect and remove suspicious background agents |
| 🔒 **Privacy Traces** | Clear browsing and activity traces |
| 📈 **Scan History** | Track how much space you've freed over time |

## Screenshots

*(Coming soon)*

## Requirements

- macOS 13.0 (Ventura) or later
- Xcode 15.0 or later (for building from source)
- Full Disk Access permission (for system scans)

## Installation

### From Release (Recommended)

1. Download the latest `FreeUp.dmg` from [Releases](https://github.com/Seaus-tech/FreeUp/releases)
2. Open the downloaded file
3. Drag FreeUp to your Applications folder
4. Launch FreeUp and grant necessary permissions

### Build from Source

```bash
# Clone the repository
git clone https://github.com/Seaus-tech/FreeUp.git
cd FreeUp

# Open in Xcode
open FreeUp.xcodeproj
```

## Usage

1. Launch FreeUp
2. Click **Scan** to analyze your system
3. Review the categorized files
4. Select items to clean
5. Click **Remove** to free up space

## Permissions

FreeUp requires Full Disk Access to scan system locations. Grant this in:

`System Preferences > Privacy & Security > Full Disk Access`

Add FreeUp to the allowed applications list.

## Development

### Building

```bash
# Open in Xcode
open FreeUp.xcodeproj

# Or build from command line
xcodebuild -project FreeUp.xcodeproj -scheme FreeUp
```

### Code Signing

For distribution, you'll need to codesign the application:

```bash
codesign --deep --force --verify --sign "Developer ID Application: Your Name" FreeUp.app
```

## Repository Structure

```
FreeUp/
├── Sources/              # Main application source code
├── Resources/            # Assets and resources
├── dmgs/                 # DMG distribution files
└── README.md             # This file
```

## Roadmap

- [ ] Add duplicate file finder
- [ ] Implement cloud storage cleanup
- [ ] Add scheduled scans
- [ ] Create system health report

## Safety Notice

> ⚠️ **FreeUp only removes files that are safe to delete.**

- System-critical files are never targeted
- Always review files before deleting
- Scan history is saved for your reference
- Backups are recommended before major cleanups

---

© 2026 Seaus Tech. All rights reserved.
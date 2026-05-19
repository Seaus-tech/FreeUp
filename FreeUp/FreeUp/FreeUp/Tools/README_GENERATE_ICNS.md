generate_icns.swift

This script renders the `FreeUpLogoView` SwiftUI view into a set of PNG images at standard macOS icon sizes and packs them into a `FreeUp.icns` file using `iconutil`.

Requirements
- macOS with Swift toolchain installed (Xcode or command line tools)
- Must be run in a graphical user session (cannot run headless)

Usage
1. Open Terminal and change directory to the project root (where `FreeUp.xcodeproj` lives):

```bash
cd /Users/YashB/Seaus/FreeUp/FreeUp/FreeUp
```

2. Run the script directly with the system swift interpreter:

```bash
swift Tools/generate_icns.swift.disabled
```

Alternatively compile and run the small binary:

```bash
swiftc Tools/generate_icns.swift -o Tools/generate_icns
Tools/generate_icns
```

What the script does
- Creates `FreeUp.iconset/` in the current directory
- Produces PNGs: icon_16x16.png, icon_16x16@2x.png, icon_32x32.png, icon_32x32@2x.png, icon_128x128.png, icon_128x128@2x.png, icon_256x256.png, icon_256x256@2x.png, icon_512x512.png, icon_512x512@2x.png
- Writes `Contents.json` for the iconset
- Calls `/usr/bin/iconutil -c icns FreeUp.iconset -o FreeUp.icns`

After successful run
- You will find `FreeUp.icns` in the project root.
- You may copy it into `Assets.xcassets/AppIcon.appiconset/` or configure the Xcode asset catalog to use the generated .icns file.

Notes
- If you want to change the accent color used to render the logo, edit the `accent` variable near the bottom of `Tools/generate_icns.swift`.
- The script duplicates the `FreeUpLogoView` implementation so it can render the view without loading the main app. If you modify the main `FreeUpLogoView.swift`, re-run the script to update the icon images.

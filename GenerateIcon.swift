#!/usr/bin/env swift
// GenerateIcon.swift — renders FreeUp app icon at all required sizes
// Run from repo root: swift GenerateIcon.swift

import AppKit
import CoreGraphics

// MARK: - Gem shapes (mirrors FreeUpLogoView logic)

func gemPath(in size: CGFloat) -> CGPath {
    let w = size, h = size
    let path = CGMutablePath()
    path.move(to: CGPoint(x: w * 0.5, y: h * 0.08))
    path.addLine(to: CGPoint(x: w * 0.28, y: h * 0.28))
    path.addLine(to: CGPoint(x: w * 0.12, y: h * 0.35))
    path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.6))
    path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.9))
    path.addLine(to: CGPoint(x: w * 0.65, y: h * 0.6))
    path.addLine(to: CGPoint(x: w * 0.88, y: h * 0.35))
    path.addLine(to: CGPoint(x: w * 0.72, y: h * 0.28))
    path.closeSubpath()
    return path
}

func renderIcon(size: Int) -> NSImage {
    let s = CGFloat(size)
    let image = NSImage(size: NSSize(width: s, height: s))
    image.lockFocus()
    guard let ctx = NSGraphicsContext.current?.cgContext else { image.unlockFocus(); return image }

    // Flip coordinate system (AppKit is flipped)
    ctx.translateBy(x: 0, y: s)
    ctx.scaleBy(x: 1, y: -1)

    let radius = s * 0.18
    let rect = CGRect(x: 0, y: 0, width: s, height: s)

    // Background: rounded rect with purple gradient
    let bgPath = CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
    ctx.addPath(bgPath)
    ctx.clip()

    let gradient = CGGradient(
        colorsSpace: CGColorSpaceCreateDeviceRGB(),
        colors: [
            CGColor(red: 0.48, green: 0.36, blue: 0.94, alpha: 0.95),  // #7b5cf0
            CGColor(red: 0.28, green: 0.18, blue: 0.62, alpha: 1.0),   // darker purple
        ] as CFArray,
        locations: [0, 1]
    )!
    ctx.drawLinearGradient(gradient,
        start: CGPoint(x: 0, y: 0),
        end: CGPoint(x: s, y: s),
        options: [])
    ctx.resetClip()

    // Gem fill (white overlay)
    let gem = gemPath(in: s * 0.86)
    ctx.saveGState()
    ctx.translateBy(x: s * 0.07, y: s * 0.07)
    ctx.addPath(gem)
    ctx.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.18))
    ctx.fillPath()

    // Gem highlight strokes
    ctx.setStrokeColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.5))
    ctx.setLineWidth(max(0.5, s * 0.018))
    let hw = s * 0.78 * 0.86, hh = s * 0.78 * 0.86
    let hx = s * 0.07 + (s * 0.86 - hw) / 2, hy = s * 0.07 + (s * 0.86 - hh) / 2
    let hPath = CGMutablePath()
    hPath.move(to: CGPoint(x: hx + hw * 0.18, y: hy + hh * 0.28))
    hPath.addLine(to: CGPoint(x: hx + hw * 0.5, y: hy + hh * 0.14))
    hPath.addLine(to: CGPoint(x: hx + hw * 0.82, y: hy + hh * 0.28))
    hPath.move(to: CGPoint(x: hx + hw * 0.34, y: hy + hh * 0.42))
    hPath.addLine(to: CGPoint(x: hx + hw * 0.5, y: hy + hh * 0.35))
    hPath.addLine(to: CGPoint(x: hx + hw * 0.66, y: hy + hh * 0.42))
    hPath.move(to: CGPoint(x: hx + hw * 0.5, y: hy + hh * 0.35))
    hPath.addLine(to: CGPoint(x: hx + hw * 0.5, y: hy + hh * 0.78))
    ctx.addPath(hPath)
    ctx.strokePath()
    ctx.restoreGState()

    // Sparkle dot (top-left)
    let dotR = s * 0.04
    ctx.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.9))
    ctx.fillEllipse(in: CGRect(x: s * 0.18, y: s * 0.14, width: dotR * 2, height: dotR * 2))

    // Sparkle star (top-right) — simple 4-point star
    if size >= 32 {
        let cx = s * 0.78, cy = s * 0.18, sr = s * 0.07
        let star = CGMutablePath()
        star.move(to: CGPoint(x: cx, y: cy - sr))
        star.addLine(to: CGPoint(x: cx + sr * 0.2, y: cy - sr * 0.2))
        star.addLine(to: CGPoint(x: cx + sr, y: cy))
        star.addLine(to: CGPoint(x: cx + sr * 0.2, y: cy + sr * 0.2))
        star.addLine(to: CGPoint(x: cx, y: cy + sr))
        star.addLine(to: CGPoint(x: cx - sr * 0.2, y: cy + sr * 0.2))
        star.addLine(to: CGPoint(x: cx - sr, y: cy))
        star.addLine(to: CGPoint(x: cx - sr * 0.2, y: cy - sr * 0.2))
        star.closeSubpath()
        ctx.addPath(star)
        ctx.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.9))
        ctx.fillPath()
    }

    image.unlockFocus()
    return image
}

func savePNG(_ image: NSImage, to path: String) {
    guard let tiff = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiff),
          let png = bitmap.representation(using: .png, properties: [:]) else {
        print("❌ Failed to encode \(path)")
        return
    }
    do {
        try png.write(to: URL(fileURLWithPath: path))
        print("✅ \(path)")
    } catch {
        print("❌ \(path): \(error)")
    }
}

// MARK: - Main

let assetDir = "FreeUp/FreeUp/FreeUp/Assets.xcassets/AppIcon.appiconset"

let sizes: [(name: String, size: Int)] = [
    ("icon_16.png",   16),
    ("icon_32.png",   32),
    ("icon_64.png",   64),   // 32@2x
    ("icon_128.png",  128),
    ("icon_256.png",  256),  // 128@2x
    ("icon_512.png",  512),
    ("icon_1024.png", 1024), // 512@2x
]

for entry in sizes {
    let path = "\(assetDir)/\(entry.name)"
    savePNG(renderIcon(size: entry.size), to: path)
}

// Update Contents.json
let contents = """
{
  "images" : [
    { "filename" : "icon_1024.png", "idiom" : "universal", "platform" : "ios", "size" : "1024x1024" },
    { "filename" : "icon_16.png",   "idiom" : "mac", "scale" : "1x", "size" : "16x16" },
    { "filename" : "icon_32.png",   "idiom" : "mac", "scale" : "2x", "size" : "16x16" },
    { "filename" : "icon_32.png",   "idiom" : "mac", "scale" : "1x", "size" : "32x32" },
    { "filename" : "icon_64.png",   "idiom" : "mac", "scale" : "2x", "size" : "32x32" },
    { "filename" : "icon_128.png",  "idiom" : "mac", "scale" : "1x", "size" : "128x128" },
    { "filename" : "icon_256.png",  "idiom" : "mac", "scale" : "2x", "size" : "128x128" },
    { "filename" : "icon_256.png",  "idiom" : "mac", "scale" : "1x", "size" : "256x256" },
    { "filename" : "icon_512.png",  "idiom" : "mac", "scale" : "2x", "size" : "256x256" },
    { "filename" : "icon_512.png",  "idiom" : "mac", "scale" : "1x", "size" : "512x512" },
    { "filename" : "icon_1024.png", "idiom" : "mac", "scale" : "2x", "size" : "512x512" }
  ],
  "info" : { "author" : "xcode", "version" : 1 }
}
"""

do {
    try contents.write(toFile: "\(assetDir)/Contents.json", atomically: true, encoding: .utf8)
    print("✅ Contents.json updated")
} catch {
    print("❌ Contents.json: \(error)")
}

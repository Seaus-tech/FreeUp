// Tools/generate_icns.swift
// Renders FreeUp app icon PNGs into Assets.xcassets/AppIcon.appiconset
// NOT part of the app target — run manually:
//   cd /Users/YashB/Seaus/FreeUp/FreeUp/FreeUp
//   swift Tools/generate_icns.swift

import AppKit
import CoreGraphics

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
    ctx.translateBy(x: 0, y: s); ctx.scaleBy(x: 1, y: -1)

    let rect = CGRect(x: 0, y: 0, width: s, height: s)
    let bgPath = CGPath(roundedRect: rect, cornerWidth: s * 0.18, cornerHeight: s * 0.18, transform: nil)
    ctx.addPath(bgPath); ctx.clip()

    let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [
        CGColor(red: 0.48, green: 0.36, blue: 0.94, alpha: 0.95),
        CGColor(red: 0.28, green: 0.18, blue: 0.62, alpha: 1.0),
    ] as CFArray, locations: [0, 1])!
    ctx.drawLinearGradient(gradient, start: .zero, end: CGPoint(x: s, y: s), options: [])
    ctx.resetClip()

    ctx.saveGState()
    ctx.translateBy(x: s * 0.07, y: s * 0.07)
    ctx.addPath(gemPath(in: s * 0.86))
    ctx.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.18)); ctx.fillPath()

    ctx.setStrokeColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.5))
    ctx.setLineWidth(max(0.5, s * 0.018))
    let hw = s * 0.86 * 0.78, hx = s * 0.07 + (s * 0.86 - hw) / 2, hy = hx
    let h = CGMutablePath()
    h.move(to: CGPoint(x: hx + hw * 0.18, y: hy + hw * 0.28))
    h.addLine(to: CGPoint(x: hx + hw * 0.5, y: hy + hw * 0.14))
    h.addLine(to: CGPoint(x: hx + hw * 0.82, y: hy + hw * 0.28))
    h.move(to: CGPoint(x: hx + hw * 0.34, y: hy + hw * 0.42))
    h.addLine(to: CGPoint(x: hx + hw * 0.5, y: hy + hw * 0.35))
    h.addLine(to: CGPoint(x: hx + hw * 0.66, y: hy + hw * 0.42))
    h.move(to: CGPoint(x: hx + hw * 0.5, y: hy + hw * 0.35))
    h.addLine(to: CGPoint(x: hx + hw * 0.5, y: hy + hw * 0.78))
    ctx.addPath(h); ctx.strokePath()
    ctx.restoreGState()

    let dotR = s * 0.04
    ctx.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.9))
    ctx.fillEllipse(in: CGRect(x: s * 0.18, y: s * 0.14, width: dotR * 2, height: dotR * 2))

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
        ctx.addPath(star); ctx.fillPath()
    }
    image.unlockFocus()
    return image
}

func savePNG(_ image: NSImage, to path: String) {
    guard let tiff = image.tiffRepresentation,
          let bmp = NSBitmapImageRep(data: tiff),
          let png = bmp.representation(using: .png, properties: [:]) else { print("❌ \(path)"); return }
    try! png.write(to: URL(fileURLWithPath: path))
    print("✅ \(path)")
}

func main() {
    let assetDir = "../FreeUp/Assets.xcassets/AppIcon.appiconset"
    let sizes = [(16,"icon_16"),(32,"icon_32"),(64,"icon_64"),(128,"icon_128"),(256,"icon_256"),(512,"icon_512"),(1024,"icon_1024")]
    for (sz, name) in sizes { savePNG(renderIcon(size: sz), to: "\(assetDir)/\(name).png") }

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
    try! contents.write(toFile: "\(assetDir)/Contents.json", atomically: true, encoding: .utf8)
    print("✅ Contents.json updated")
}

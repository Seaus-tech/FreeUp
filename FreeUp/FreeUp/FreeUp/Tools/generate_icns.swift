#!/usr/bin/swift
import Foundation
import AppKit
import SwiftUI

// MARK: - Liquid Glass Logo View (self-contained for script)
struct LiquidGlassLogo: View {
    let accent: NSColor
    var body: some View {
        let accentColor = Color(accent)
        return ZStack {
            // Glow backdrop
            RoundedRectangle(cornerRadius: 60, style: .continuous)
                .fill(accentColor.opacity(0.18))
                .frame(width: 880, height: 880)
                .blur(radius: 60)
            // Glass tile
            RoundedRectangle(cornerRadius: 180, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [accentColor.opacity(0.65), accentColor.opacity(0.28), Color.white.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 180, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.45), Color.white.opacity(0.08)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                )
                .shadow(color: accentColor.opacity(0.55), radius: 90, y: 30)
                .frame(width: 760, height: 760)

            // Center glyph (shield)
            GeometryReader { g in
                let w = min(g.size.width, g.size.height)
                Path { p in
                    p.move(to: CGPoint(x: w * 0.5, y: w * 0.18))
                    p.addLine(to: CGPoint(x: w * 0.84, y: w * 0.32))
                    p.addLine(to: CGPoint(x: w * 0.74, y: w * 0.76))
                    p.addLine(to: CGPoint(x: w * 0.5, y: w * 0.66))
                    p.addLine(to: CGPoint(x: w * 0.26, y: w * 0.76))
                    p.addLine(to: CGPoint(x: w * 0.16, y: w * 0.32))
                    p.closeSubpath()
                }
                .fill(
                    LinearGradient(colors: [accentColor, accentColor.opacity(0.75)], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: w * 0.5, height: w * 0.5)
                .position(x: g.size.width/2, y: g.size.height/2)
            }
            .frame(width: 760, height: 760)
        }
        .frame(width: 1024, height: 1024)
        .background(Color.clear)
    }
}

// MARK: - Renderer
@MainActor
func renderPNG(view: some View, size: CGSize, url: URL) throws {
    let hosting = NSHostingView(rootView: view.frame(width: size.width, height: size.height))
    hosting.frame = CGRect(origin: .zero, size: size)

    let rep = hosting.bitmapImageRepForCachingDisplay(in: hosting.bounds)!
    rep.size = size
    hosting.cacheDisplay(in: hosting.bounds, to: rep)

    guard let data = rep.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "render", code: 1, userInfo: [NSLocalizedDescriptionKey: "PNG encoding failed"])
    }
    try data.write(to: url)
}

// MARK: - Main
@MainActor
func main() async throws {
    let fm = FileManager.default
    let cwd = URL(fileURLWithPath: fm.currentDirectoryPath)
    let iconset = cwd.appendingPathComponent("FreeUp.iconset", isDirectory: true)
    if fm.fileExists(atPath: iconset.path) {
        try? fm.removeItem(at: iconset)
    }
    try fm.createDirectory(at: iconset, withIntermediateDirectories: true)

    // Standard macOS icon sizes
    let sizes: [(base: Int, scale: Int)] = [
        (16,1),(16,2),
        (32,1),(32,2),
        (128,1),(128,2),
        (256,1),(256,2),
        (512,1),(512,2),
    ]

    let accent = NSColor(calibratedRed: 0.482, green: 0.361, blue: 0.941, alpha: 1.0) // #7b5cf0
    let baseView = LiquidGlassLogo(accent: accent)

    for (base, scale) in sizes {
        let px = base * scale
        let name = "icon_\(base)x\(base)\(scale == 2 ? "@2x" : "").png"
        let url = iconset.appendingPathComponent(name)
        try renderPNG(view: baseView, size: CGSize(width: px, height: px), url: url)
        print("Wrote \(name)")
    }

    // Contents.json for the iconset
    let contents: String = {
        var items: [[String: Any]] = []
        func entry(_ size: String, _ scale: String) -> [String: Any] {
            return ["size": size, "idiom": "mac", "filename": "icon_\(size.replacingOccurrences(of: " ", with: ""))\(scale == "2x" ? "@2x" : "").png", "scale": scale]
        }
        let mapping: [(String,String)] = [
            ("16x16","1x"),("16x16","2x"),
            ("32x32","1x"),("32x32","2x"),
            ("128x128","1x"),("128x128","2x"),
            ("256x256","1x"),("256x256","2x"),
            ("512x512","1x"),("512x512","2x"),
        ]
        for (s, sc) in mapping { items.append(entry(s, sc)) }
        let dict: [String: Any] = ["images": items, "info": ["version": 1, "author": "xcode"]]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted, .sortedKeys])
        return String(data: data, encoding: .utf8)!
    }()
    try contents.data(using: .utf8)!.write(to: iconset.appendingPathComponent("Contents.json"))
    print("Wrote Contents.json")

    // Build icns
    let icnsURL = cwd.appendingPathComponent("FreeUp.icns")
    if fm.fileExists(atPath: icnsURL.path) { try? fm.removeItem(at: icnsURL) }
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/iconutil")
    task.arguments = ["-c", "icns", iconset.path, "-o", icnsURL.path]
    try task.run()
    task.waitUntilExit()
    if task.terminationStatus == 0 { print("Created FreeUp.icns") } else { print("iconutil failed with status \(task.terminationStatus)") }
}

import AppKit
let app = NSApplication.shared
Task { try? await main() ; NSApp.terminate(nil) }
app.run()

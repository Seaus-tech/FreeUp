import SwiftUI

// FreeUpIcons.swift
// A small collection of simple, original SwiftUI vector icons to match the FreeUp brand.
// Use these in place of proprietary artwork or SF Symbols when you want a cohesive look.

// Usage example:
// IconTrash(accent: .accentColor).frame(width: 28, height: 28)

public struct IconTrash: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            let stroke = max(1, w * 0.07)
            ZStack {
                // can body
                RoundedRectangle(cornerRadius: w * 0.08)
                    .stroke(accent, lineWidth: stroke)
                    .frame(width: w * 0.66, height: w * 0.56)
                    .offset(y: w * 0.12)

                // lid
                RoundedRectangle(cornerRadius: w * 0.04)
                    .fill(accent)
                    .frame(width: w * 0.86, height: w * 0.16)
                    .offset(y: -w * 0.18)

                // handle
                RoundedRectangle(cornerRadius: w * 0.03)
                    .fill(accent.opacity(0.9))
                    .frame(width: w * 0.32, height: w * 0.06)
                    .offset(y: -w * 0.26)
            }
            // compensate for the vertical offsets used for lid/handle so the visual
            // center of the trash icon is actually centered in the provided frame.
            .frame(width: w, height: w)
            .offset(y: w * 0.07)
        }
    }
}

public struct IconShield: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            Path { p in
                p.move(to: CGPoint(x: w * 0.5, y: 0))
                p.addLine(to: CGPoint(x: w * 0.95, y: w * 0.22))
                p.addLine(to: CGPoint(x: w * 0.8, y: w * 0.9))
                p.addLine(to: CGPoint(x: w * 0.5, y: w * 0.78))
                p.addLine(to: CGPoint(x: w * 0.2, y: w * 0.9))
                p.addLine(to: CGPoint(x: w * 0.05, y: w * 0.22))
                p.closeSubpath()
            }
            .fill(LinearGradient(colors: [accent, accent.opacity(0.7)], startPoint: .top, endPoint: .bottom))
        }
    }
}

public struct IconGear: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            let tooth = w * 0.12
            ZStack {
                // central hole
                Circle()
                    .fill(Color.white)
                    .frame(width: w * 0.34, height: w * 0.34)

                Circle()
                    .stroke(accent, lineWidth: max(1, w * 0.06))
                    .frame(width: w * 0.74, height: w * 0.74)

                ForEach(0..<8) { i in
                    Rectangle()
                        .fill(accent)
                        .frame(width: tooth, height: w * 0.18)
                        .offset(y: -(w * 0.44 - (w * 0.09)))
                        .rotationEffect(.degrees(Double(i) / 8.0 * 360.0))
                }
            }
            .frame(width: w, height: w)
        }
    }
}

public struct IconDownload: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            let shaft = w * 0.12
            ZStack {
                // box
                RoundedRectangle(cornerRadius: w * 0.06)
                    .stroke(accent, lineWidth: max(1, shaft))
                    .frame(width: w * 0.7, height: w * 0.36)
                    .offset(y: w * 0.18)

                // arrow
                Path { p in
                    p.move(to: CGPoint(x: w * 0.2, y: w * 0.35))
                    p.addLine(to: CGPoint(x: w * 0.5, y: w * 0.65))
                    p.addLine(to: CGPoint(x: w * 0.8, y: w * 0.35))
                    p.addLine(to: CGPoint(x: w * 0.6, y: w * 0.35))
                    p.addLine(to: CGPoint(x: w * 0.6, y: w * 0.05))
                    p.addLine(to: CGPoint(x: w * 0.4, y: w * 0.05))
                    p.addLine(to: CGPoint(x: w * 0.4, y: w * 0.35))
                    p.closeSubpath()
                }
                .fill(accent)
            }
        }
    }
}

public struct IconMail: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            Path { p in
                let rect = CGRect(x: w * 0.06, y: w * 0.18, width: w * 0.88, height: w * 0.6)
                p.addRoundedRect(in: rect, cornerSize: CGSize(width: w * 0.04, height: w * 0.04))
                p.move(to: CGPoint(x: rect.minX, y: rect.minY))
                p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + w * 0.02))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            }
            .stroke(accent, lineWidth: max(1, w * 0.06))
        }
    }
}

public struct IconFolder: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: w * 0.06)
                    .stroke(accent, lineWidth: max(1, w * 0.06))
                    .frame(width: w * 0.9, height: w * 0.62)
                    .offset(x: w * 0.05, y: w * 0.18)

                RoundedRectangle(cornerRadius: w * 0.04)
                    .fill(accent)
                    .frame(width: w * 0.38, height: w * 0.18)
                    .offset(x: w * 0.08, y: 0)
                    .opacity(0.12)
            }
        }
    }
}

public struct IconSparkle: View {
    public let accent: Color
    public init(accent: Color = .accentColor) { self.accent = accent }

    public var body: some View {
        GeometryReader { g in
            let w = min(g.size.width, g.size.height)
            ZStack {
                Path { p in
                    p.move(to: CGPoint(x: w * 0.5, y: w * 0.05))
                    p.addLine(to: CGPoint(x: w * 0.55, y: w * 0.28))
                    p.addLine(to: CGPoint(x: w * 0.78, y: w * 0.33))
                    p.addLine(to: CGPoint(x: w * 0.6, y: w * 0.5))
                    p.addLine(to: CGPoint(x: w * 0.65, y: w * 0.75))
                    p.addLine(to: CGPoint(x: w * 0.5, y: w * 0.6))
                    p.addLine(to: CGPoint(x: w * 0.35, y: w * 0.75))
                    p.addLine(to: CGPoint(x: w * 0.4, y: w * 0.5))
                    p.addLine(to: CGPoint(x: w * 0.22, y: w * 0.33))
                    p.addLine(to: CGPoint(x: w * 0.45, y: w * 0.28))
                    p.closeSubpath()
                }
                .fill(accent)
            }
        }
    }
}

// Previews
struct FreeUpIcons_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                IconShield(accent: Color(hex: "7b5cf0")).frame(width: 44, height: 44)
                IconGear(accent: Color(hex: "7b5cf0")).frame(width: 44, height: 44)
                IconTrash(accent: Color(hex: "7b5cf0")).frame(width: 44, height: 44)
            }
            HStack(spacing: 12) {
                IconDownload(accent: .green).frame(width: 44, height: 44)
                IconMail(accent: .orange).frame(width: 44, height: 44)
                IconFolder(accent: .yellow).frame(width: 44, height: 44)
            }
            IconSparkle(accent: .white).frame(width: 80, height: 80).background(Color.black)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

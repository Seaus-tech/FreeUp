import SwiftUI

struct FreeUpLogoView: View {
    let accent: Color

    var body: some View {
        GeometryReader { geo in
            let w = min(geo.size.width, geo.size.height)
            ZStack {
                // background rounded gem
                RoundedRectangle(cornerRadius: w * 0.18, style: .continuous)
                    .fill(LinearGradient(colors: [accent.opacity(0.95), accent.opacity(0.45), Color.white.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: w, height: w)
                    .shadow(color: accent.opacity(0.25), radius: w * 0.12, x: 0, y: w * 0.06)

                // faceted gem polygon
                GemShape()
                    .fill(LinearGradient(colors: [Color.white.opacity(0.22), Color.white.opacity(0.05)], startPoint: .top, endPoint: .bottom))
                    .blendMode(.overlay)
                    .frame(width: w * 0.86, height: w * 0.86)

                // highlight facets
                GemHighlights()
                    .stroke(Color.white.opacity(0.45), lineWidth: max(0.5, w * 0.02))
                    .frame(width: w * 0.78, height: w * 0.78)

                // small star sparkle
                Group {
                    Circle().fill(Color.white.opacity(0.9)).frame(width: w * 0.06, height: w * 0.06).offset(x: -w * 0.18, y: -w * 0.24)
                    Image(systemName: "sparkles").font(.system(size: w * 0.12)).foregroundStyle(Color.white.opacity(0.9)).offset(x: w * 0.22, y: -w * 0.22)
                }
            }
            .frame(width: w, height: w)
            .compositingGroup()
        }
    }
}

struct GemShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        let topCenter = CGPoint(x: w * 0.5, y: h * 0.08)
        let left = CGPoint(x: w * 0.12, y: h * 0.35)
        let right = CGPoint(x: w * 0.88, y: h * 0.35)
        let bottom = CGPoint(x: w * 0.5, y: h * 0.9)

        p.move(to: topCenter)
        p.addLine(to: CGPoint(x: w * 0.28, y: h * 0.28))
        p.addLine(to: left)
        p.addLine(to: CGPoint(x: w * 0.35, y: h * 0.6))
        p.addLine(to: bottom)
        p.addLine(to: CGPoint(x: w * 0.65, y: h * 0.6))
        p.addLine(to: right)
        p.addLine(to: CGPoint(x: w * 0.72, y: h * 0.28))
        p.closeSubpath()
        return p
    }
}

struct GemHighlights: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let w = rect.width
        let h = rect.height
        p.move(to: CGPoint(x: w * 0.18, y: h * 0.28))
        p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.14))
        p.addLine(to: CGPoint(x: w * 0.82, y: h * 0.28))
        p.move(to: CGPoint(x: w * 0.34, y: h * 0.42))
        p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.35))
        p.addLine(to: CGPoint(x: w * 0.66, y: h * 0.42))
        p.move(to: CGPoint(x: w * 0.5, y: h * 0.35))
        p.addLine(to: CGPoint(x: w * 0.5, y: h * 0.78))
        return p
    }
}

struct FreeUpLogoView_Previews: PreviewProvider {
    static var previews: some View {
        FreeUpLogoView(accent: Color(hex: "7b5cf0")).frame(width: 160, height: 160)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black)
    }
}

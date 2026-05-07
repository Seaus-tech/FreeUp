import SwiftUI

// MARK: - Section Model

enum AppSection: String, CaseIterable, Identifiable {
    case smartCare   = "Smart Care"
    case cleanup     = "Cleanup"
    case protection  = "Protection"
    case performance = "Performance"
    case applications = "Applications"
    case myClutter   = "My Clutter"
    case spaceLens   = "Space Lens"
    case cloudCleanup = "Cloud Cleanup"
    case myTools     = "My Tools"
    case myActivity  = "My Activity"

    var id: String { rawValue }

    var sidebarIcon: String {
        switch self {
        case .smartCare:    "sparkles.rectangle.stack"
        case .cleanup:      "circle.dotted"
        case .protection:   "hand.raised"
        case .performance:  "bolt"
        case .applications: "xmark.app"
        case .myClutter:    "tray.2"
        case .spaceLens:    "circle.dotted.and.circle"
        case .cloudCleanup: "cloud"
        case .myTools:      "square.stack.3d.up"
        case .myActivity:   "chart.line.uptrend.xyaxis"
        }
    }

    var heroIcon: String {
        switch self {
        case .smartCare:    "sparkles"
        case .cleanup:      "internaldrive"
        case .protection:   "shield"
        case .performance:  "gauge.with.dots.needle.67percent"
        case .applications: "xmark.app.fill"
        case .myClutter:    "folder"
        case .spaceLens:    "magnifyingglass.circle"
        case .cloudCleanup: "icloud"
        case .myTools:      "wrench.and.screwdriver"
        case .myActivity:   "chart.bar"
        }
    }

    var title: String { rawValue }

    var subtitle: String {
        switch self {
        case .smartCare:    "Run a full system scan and fix issues automatically."
        case .cleanup:      "Remove junk files, caches, and logs to free up space."
        case .protection:   "Keep your Mac safe from threats and vulnerabilities."
        case .performance:  "Speed up your Mac by managing startup items and RAM."
        case .applications: "Take control of your applications. Uninstall, update or remove old application leftovers."
        case .myClutter:    "Sort through your files and reduce the mess in just a few clicks."
        case .spaceLens:    "Visualize what's taking up the most disk space and clean up your storage quickly."
        case .cloudCleanup: "Clean up your cloud storage and free up space online."
        case .myTools:      "A collection of handy tools to keep your Mac in shape."
        case .myActivity:   "Track what FreeUp has cleaned and protected over time."
        }
    }

    var features: [(icon: String, label: String)] {
        switch self {
        case .smartCare:
            return [("sparkles", "Smart Scan"), ("shield.checkered", "Quick Fix"), ("chart.bar.fill", "Health Report")]
        case .cleanup:
            return [("internaldrive", "System Junk"), ("app.badge", "App Leftovers"), ("clock.arrow.circlepath", "Old Caches")]
        case .protection:
            return [("lock.shield", "Malware Removal"), ("eye.slash", "Privacy Cleaner"), ("network", "Network Guard")]
        case .performance:
            return [("bolt.fill", "Speed Up"), ("memorychip", "RAM Cleaner"), ("power", "Login Items")]
        case .applications:
            return [("xmark.circle.fill", "App Uninstaller"), ("arrow.up.circle.fill", "App Updater"), ("doc.badge.arrow.up", "File Leftovers")]
        case .myClutter:
            return [("doc.fill", "Large Files"), ("doc.on.doc.fill", "Duplicates"), ("photo.on.rectangle.angled", "Similar Images"), ("arrow.down.circle.fill", "Downloads")]
        case .spaceLens:
            return [("map.fill", "Visual Storage Map"), ("eye.fill", "Hidden Files Uncovered"), ("folder.fill", "Large Folders Overview")]
        case .cloudCleanup:
            return [("icloud.fill", "iCloud Drive"), ("photo.fill", "Photo Library"), ("envelope.fill", "Mail Attachments")]
        case .myTools:
            return [("wrench.fill", "Disk Utility"), ("terminal.fill", "System Info"), ("gearshape.fill", "Preferences")]
        case .myActivity:
            return [("chart.line.uptrend.xyaxis", "Scan History"), ("trash.fill", "Cleaned Files"), ("clock.fill", "Recent Activity")]
        }
    }

    // Background gradient colors
    var gradientColors: [Color] {
        switch self {
        case .smartCare:    return [Color(hex: "1a1060"), Color(hex: "2d1b8e"), Color(hex: "1a0a5e")]
        case .cleanup:      return [Color(hex: "0a2a4a"), Color(hex: "0d3d6b"), Color(hex: "071e35")]
        case .protection:   return [Color(hex: "3a0a4a"), Color(hex: "6b0d7a"), Color(hex: "250535")]
        case .performance:  return [Color(hex: "4a2000"), Color(hex: "7a3800"), Color(hex: "2a1000")]
        case .applications: return [Color(hex: "0a1a4a"), Color(hex: "0d2a7a"), Color(hex: "060f2e")]
        case .myClutter:    return [Color(hex: "0a3a2a"), Color(hex: "0d5a3d"), Color(hex: "062518")]
        case .spaceLens:    return [Color(hex: "1a0a5e"), Color(hex: "3d0d9e"), Color(hex: "0f0635")]
        case .cloudCleanup: return [Color(hex: "0a2a3a"), Color(hex: "0d4a6b"), Color(hex: "061825")]
        case .myTools:      return [Color(hex: "1a1a1a"), Color(hex: "2d2d2d"), Color(hex: "0a0a0a")]
        case .myActivity:   return [Color(hex: "0a1a0a"), Color(hex: "0d3a0d"), Color(hex: "060f06")]
        }
    }

    var accentColor: Color {
        switch self {
        case .smartCare:    return Color(hex: "7b5cf0")
        case .cleanup:      return Color(hex: "3b82f6")
        case .protection:   return Color(hex: "ec4899")
        case .performance:  return Color(hex: "f97316")
        case .applications: return Color(hex: "4f8ef7")
        case .myClutter:    return Color(hex: "2dd4bf")
        case .spaceLens:    return Color(hex: "8b5cf6")
        case .cloudCleanup: return Color(hex: "38bdf8")
        case .myTools:      return Color(hex: "94a3b8")
        case .myActivity:   return Color(hex: "22c55e")
        }
    }

    var category: CleanerEngine.CleanItem.Category? {
        switch self {
        case .cleanup:      return .cache
        case .myClutter:    return .largeFile
        case .cloudCleanup: return .trash
        case .spaceLens:    return .downloads
        default:            return nil
        }
    }

    var isSeparatorBefore: Bool { self == .myTools }
}

// MARK: - ContentView

struct ContentView: View {
    @StateObject private var engine = CleanerEngine()
    @State private var selected: AppSection = .smartCare
    @State private var showResults = false

    var body: some View {
        #if os(macOS)
        ZStack {
            // Full-window gradient background
            LinearGradient(
                colors: selected.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.4), value: selected)

            HStack(spacing: 0) {
                sidebarView
                mainArea
            }
        }
        .frame(minWidth: 860, minHeight: 560)
        #else
        mobileView
        #endif
    }

    // MARK: - Sidebar

    private var sidebarView: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top padding for traffic lights
            Spacer().frame(height: 52)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(AppSection.allCases) { section in
                        if section.isSeparatorBefore {
                            Divider()
                                .background(Color.white.opacity(0.15))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                        }
                        SidebarItem(section: section, isSelected: selected == section, accent: selected.accentColor)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    selected = section
                                    showResults = false
                                }
                            }
                    }
                }
                .padding(.bottom, 16)
            }

            Spacer()
        }
        .frame(width: 210)
        .background(Color.black.opacity(0.25))
    }

    // MARK: - Main Area

    private var mainArea: some View {
        ZStack(alignment: .bottom) {
            if showResults && !filteredItems.isEmpty {
                resultsView
            } else {
                heroView
            }

            // Circular Scan button
            scanButton
                .padding(.bottom, 28)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Hero View

    private var heroView: some View {
        HStack(alignment: .center, spacing: 0) {
            // Center illustration
            ZStack {
                if engine.isScanning {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.white)
                } else {
                    HeroGem(icon: selected.heroIcon, accent: selected.accentColor)
                }
            }
            .frame(maxWidth: .infinity)

            // Right info panel
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(selected.title)
                        .font(.system(size: 36, weight: .semibold, design: .default))
                        .foregroundStyle(.white)
                    Text(selected.subtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 280)
                }

                VStack(alignment: .leading, spacing: 14) {
                    ForEach(selected.features, id: \.label) { feature in
                        FeatureRow(icon: feature.icon, label: feature.label, accent: selected.accentColor)
                    }
                }

                Spacer()
            }
            .frame(width: 320)
            .padding(.trailing, 48)
            .padding(.top, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Results View

    private var resultsView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(filteredItems.count) items · \(engine.scannedBytes.formatted(.byteCount(style: .file)))")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                Button("Clean All") {
                    Task { await engine.clearAll() }
                }
                .buttonStyle(PillButtonStyle(color: selected.accentColor))
                .disabled(engine.isClearing)
            }
            .padding(.horizontal, 32)
            .padding(.top, 24)
            .padding(.bottom, 12)

            List(filteredItems) { item in
                ResultRow(item: item, accent: selected.accentColor)
                    .listRowBackground(Color.white.opacity(0.05))
                    .listRowSeparatorTint(.white.opacity(0.1))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)

            Spacer().frame(height: 80) // space for scan button
        }
    }

    // MARK: - Scan Button

    private var scanButton: some View {
        Button {
            if showResults {
                showResults = false
                engine.items = []
            } else {
                Task {
                    await engine.scan()
                    if !filteredItems.isEmpty { showResults = true }
                }
            }
        } label: {
            ZStack {
                Circle()
                    .fill(selected.accentColor.opacity(0.35))
                    .frame(width: 72, height: 72)
                Circle()
                    .fill(selected.accentColor.opacity(0.6))
                    .frame(width: 60, height: 60)
                if engine.isScanning {
                    ProgressView().tint(.white)
                } else {
                    Text(showResults ? "Rescan" : "Scan")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(engine.isScanning || engine.isClearing)
        .shadow(color: selected.accentColor.opacity(0.6), radius: 16, y: 4)
    }

    // MARK: - Mobile

    private var mobileView: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: selected.gradientColors, startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                heroView
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu {
                        ForEach(AppSection.allCases) { s in
                            Button(s.rawValue) { selected = s }
                        }
                    } label: {
                        Label(selected.rawValue, systemImage: selected.sidebarIcon)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }

    private var filteredItems: [CleanerEngine.CleanItem] {
        guard let cat = selected.category else { return engine.items }
        return engine.items.filter { $0.category == cat }
    }
}

// MARK: - Sidebar Item

private struct SidebarItem: View {
    let section: AppSection
    let isSelected: Bool
    let accent: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: section.sidebarIcon)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(isSelected ? .white : .white.opacity(0.55))
                .frame(width: 20)
            Text(section.rawValue)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? .white : .white.opacity(0.65))
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(
            isSelected
                ? RoundedRectangle(cornerRadius: 8).fill(accent.opacity(0.35))
                : nil
        )
        .padding(.horizontal, 10)
        .contentShape(Rectangle())
    }
}

// MARK: - Hero Gem (3D rounded-square with icon)

private struct HeroGem: View {
    let icon: String
    let accent: Color

    var body: some View {
        ZStack {
            // Outer glow
            RoundedRectangle(cornerRadius: 60, style: .continuous)
                .fill(accent.opacity(0.15))
                .frame(width: 300, height: 300)
                .blur(radius: 30)

            // Gem shape
            RoundedRectangle(cornerRadius: 52, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [accent.opacity(0.55), accent.opacity(0.2), Color.white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 240, height: 240)
                .overlay(
                    RoundedRectangle(cornerRadius: 52, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.4), Color.white.opacity(0.05)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                )
                .shadow(color: accent.opacity(0.5), radius: 40, y: 20)

            Image(systemName: icon)
                .font(.system(size: 80, weight: .thin))
                .foregroundStyle(.white.opacity(0.9))
                .shadow(color: .white.opacity(0.3), radius: 8)
        }
    }
}

// MARK: - Feature Row

private struct FeatureRow: View {
    let icon: String
    let label: String
    let accent: Color

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(accent.opacity(0.3))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white)
            }
            Text(label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
}

// MARK: - Result Row

private struct ResultRow: View {
    let item: CleanerEngine.CleanItem
    let accent: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: item.category.icon)
                .foregroundStyle(accent)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.url.lastPathComponent)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Text(item.url.deletingLastPathComponent().path)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.45))
                    .lineLimit(1)
            }
            Spacer()
            Text(item.size.formatted(.byteCount(style: .file)))
                .font(.subheadline.monospacedDigit())
                .foregroundStyle(.white.opacity(0.7))
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Pill Button Style

private struct PillButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 7)
            .background(color.opacity(configuration.isPressed ? 0.5 : 0.7), in: Capsule())
    }
}

// MARK: - Color Hex Init

extension Color {
    init(hex: String) {
        let v = UInt64(hex, radix: 16) ?? 0
        let r = Double((v >> 16) & 0xff) / 255
        let g = Double((v >> 8) & 0xff) / 255
        let b = Double(v & 0xff) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Category Icon

extension CleanerEngine.CleanItem.Category {
    var icon: String {
        switch self {
        case .cache:     "internaldrive"
        case .temp:      "clock"
        case .largeFile: "doc.zipper"
        case .trash:     "trash"
        case .downloads: "arrow.down.circle"
        }
    }
}

#Preview {
    ContentView()
}

import SwiftUI
#if os(macOS)
import AppKit
#endif

// MARK: - Tool Card Model

struct ToolCard: Identifiable {
    let id = UUID()
    let icon: String
    let iconColor: Color
    let title: String
    let description: String
    let hasLocationPicker: Bool
}

let allToolCards: [ToolCard] = [
    ToolCard(icon: "checkmark.shield.fill", iconColor: Color(hex: "e040fb"), title: "Privacy Items", description: "Remove browsing history and activity traces to protect your privacy.", hasLocationPicker: false),
    ToolCard(icon: "doc.fill", iconColor: Color(hex: "26a69a"), title: "Large and Old Files", description: "Find and remove large, unused files that take up space on your Mac.", hasLocationPicker: true),
    ToolCard(icon: "arrow.up.circle.fill", iconColor: Color(hex: "2979ff"), title: "App Updater", description: "Keep an eye on the latest and most reliable versions of your applications.", hasLocationPicker: false),
    ToolCard(icon: "trash.fill", iconColor: Color(hex: "43a047"), title: "System Junk", description: "Remove redundant files that clog up device storage and impede optimal performance.", hasLocationPicker: false),
    ToolCard(icon: "xmark.app.fill", iconColor: Color(hex: "1e88e5"), title: "Uninstaller", description: "Correctly remove entire applications with all of the related files.", hasLocationPicker: false),
    ToolCard(icon: "ant.fill", iconColor: Color(hex: "e91e8c"), title: "Malware Finder", description: "Identify and remove malicious items to keep your Mac secure.", hasLocationPicker: false),
    ToolCard(icon: "power.circle.fill", iconColor: Color(hex: "fb8c00"), title: "Login Items", description: "Manage apps that open automatically when you start your Mac.", hasLocationPicker: false),
    ToolCard(icon: "wrench.fill", iconColor: Color(hex: "f4511e"), title: "Maintenance Tasks", description: "Run a set of recommended maintenance tasks to bring your Mac to its max.", hasLocationPicker: false),
    ToolCard(icon: "arrow.down.circle.fill", iconColor: Color(hex: "00897b"), title: "Downloads", description: "Review and clean one-time use files from Downloads to keep folders tidy.", hasLocationPicker: true),
    ToolCard(icon: "puzzlepiece.fill", iconColor: Color(hex: "3949ab"), title: "App Leftovers", description: "Locate and remove app leftovers even if the main app is already gone.", hasLocationPicker: false),
    ToolCard(icon: "clock.arrow.circlepath", iconColor: Color(hex: "f57c00"), title: "Time Machine Snapshot", description: "Remove local Time Machine snapshots without affecting your backups.", hasLocationPicker: false),
    ToolCard(icon: "bell.badge.fill", iconColor: Color(hex: "e65100"), title: "Background Items", description: "Manage background apps and processes running on your Mac.", hasLocationPicker: false),
    ToolCard(icon: "lock.open.fill", iconColor: Color(hex: "e91e63"), title: "Application Permissions", description: "Manage how apps access system features, devices, and functionality.", hasLocationPicker: false),
    ToolCard(icon: "photo.on.rectangle.angled", iconColor: Color(hex: "00acc1"), title: "Similar Images", description: "Review similar photos and keep only the best ones.", hasLocationPicker: true),
    ToolCard(icon: "doc.on.doc.fill", iconColor: Color(hex: "00897b"), title: "Duplicate Finder", description: "Remove duplicate files stored in different locations on your Mac.", hasLocationPicker: true),
    ToolCard(icon: "trash.circle.fill", iconColor: Color(hex: "43a047"), title: "Trash Bins", description: "Empty all of the available Trash Bins on your Mac.", hasLocationPicker: false),
    ToolCard(icon: "envelope.fill", iconColor: Color(hex: "43a047"), title: "Mail Attachments", description: "Remove locally stored email attachments to free space while keeping modified files.", hasLocationPicker: false),
]

// MARK: - Section Model

enum AppSection: String, CaseIterable, Identifiable {
    case smartCare    = "Smart Care"
    case cleanup      = "Cleanup"
    case protection   = "Protection"
    case performance  = "Performance"
    case applications = "Applications"
    case myClutter    = "My Clutter"
    case spaceLens    = "Space Lens"
    case cloudCleanup = "Cloud Cleanup"
    case myTools      = "My Tools"
    case myActivity   = "My Activity"
    case aiAssistant  = "AI Assistant"

    var id: String { rawValue }

    var sidebarIcon: String {
        switch self {
        case .smartCare:    return "sparkles.rectangle.stack"
        case .cleanup:      return "circle.dotted"
        case .protection:   return "hand.raised"
        case .performance:  return "bolt"
        case .applications: return "xmark.app"
        case .myClutter:    return "tray.2"
        case .spaceLens:    return "circle.dotted.and.circle"
        case .cloudCleanup: return "cloud"
        case .myTools:      return "square.stack.3d.up"
        case .myActivity:   return "chart.line.uptrend.xyaxis"
        case .aiAssistant:  return "sparkles"
        }
    }

    var heroIcon: String {
        switch self {
        case .smartCare:    return "sparkles"
        case .cleanup:      return "internaldrive"
        case .protection:   return "shield"
        case .performance:  return "gauge.with.dots.needle.67percent"
        case .applications: return "xmark.app.fill"
        case .myClutter:    return "folder"
        case .spaceLens:    return "magnifyingglass.circle"
        case .cloudCleanup: return "icloud"
        case .myTools:      return "wrench.and.screwdriver"
        case .myActivity:   return "chart.bar"
        case .aiAssistant:  return "sparkles"
        }
    }

    var subtitle: String {
        switch self {
        case .smartCare:    return "Run a full system scan and fix issues automatically."
        case .cleanup:      return "Remove junk files, caches, and logs to free up space."
        case .protection:   return "Keep your Mac safe from threats and vulnerabilities."
        case .performance:  return "Speed up your Mac by managing startup items and RAM."
        case .applications: return "Take control of your applications. Uninstall, update or remove old application leftovers."
        case .myClutter:    return "Sort through your files and reduce the mess in just a few clicks."
        case .spaceLens:    return "Visualize what's taking up the most disk space and clean up your storage quickly."
        case .cloudCleanup: return "Clean up your cloud storage and free up space online."
        case .myTools:      return "Your go-to tools for keeping your Mac clean, safe and running smoothly."
        case .myActivity:   return "Track what FreeUp has cleaned and protected over time."
        case .aiAssistant:  return "Ask AI to scan, clean, and explain what's on your Mac."
        }
    }

    var features: [(icon: String, label: String)] {
        switch self {
        case .smartCare:    return [("sparkles","Smart Scan"),("shield.checkered","Quick Fix"),("chart.bar.fill","Health Report")]
        case .cleanup:      return [("internaldrive","System Junk"),("app.badge","App Leftovers"),("clock.arrow.circlepath","Old Caches")]
        case .protection:   return [("lock.shield","Malware Removal"),("eye.slash","Privacy Cleaner"),("network","Network Guard")]
        case .performance:  return [("bolt.fill","Speed Up"),("memorychip","RAM Cleaner"),("power","Login Items")]
        case .applications: return [("xmark.circle.fill","App Uninstaller"),("arrow.up.circle.fill","App Updater"),("doc.badge.arrow.up","File Leftovers")]
        case .myClutter:    return [("doc.fill","Large Files"),("doc.on.doc.fill","Duplicates"),("photo.on.rectangle.angled","Similar Images"),("arrow.down.circle.fill","Downloads")]
        case .spaceLens:    return [("map.fill","Visual Storage Map"),("eye.fill","Hidden Files Uncovered"),("folder.fill","Large Folders Overview")]
        case .cloudCleanup: return []
        case .myTools:      return []
        case .myActivity:   return []
        case .aiAssistant:  return []
        }
    }

    var gradientColors: [Color] {
        switch self {
        case .smartCare:    return [Color(hex:"1a1060"),Color(hex:"2d1b8e"),Color(hex:"1a0a5e")]
        case .cleanup:      return [Color(hex:"0a2a4a"),Color(hex:"0d3d6b"),Color(hex:"071e35")]
        case .protection:   return [Color(hex:"3a0a4a"),Color(hex:"6b0d7a"),Color(hex:"250535")]
        case .performance:  return [Color(hex:"4a2000"),Color(hex:"7a3800"),Color(hex:"2a1000")]
        case .applications: return [Color(hex:"0a1a4a"),Color(hex:"0d2a7a"),Color(hex:"060f2e")]
        case .myClutter:    return [Color(hex:"0a3a2a"),Color(hex:"0d5a3d"),Color(hex:"062518")]
        case .spaceLens:    return [Color(hex:"1a0a5e"),Color(hex:"3d0d9e"),Color(hex:"0f0635")]
        case .cloudCleanup: return [Color(hex:"0a2a3a"),Color(hex:"0d4a6b"),Color(hex:"061825")]
        case .myTools:      return [Color(hex:"1e1535"),Color(hex:"2a1f4a"),Color(hex:"150e28")]
        case .myActivity:   return [Color(hex:"0f0f2e"),Color(hex:"1a1a4a"),Color(hex:"0a0a1e")]
        case .aiAssistant:  return [Color(hex:"1a0a3e"),Color(hex:"2d1060"),Color(hex:"0f0525")]
        }
    }

    var accentColor: Color {
        switch self {
        case .smartCare:    return Color(hex:"7b5cf0")
        case .cleanup:      return Color(hex:"3b82f6")
        case .protection:   return Color(hex:"ec4899")
        case .performance:  return Color(hex:"f97316")
        case .applications: return Color(hex:"4f8ef7")
        case .myClutter:    return Color(hex:"2dd4bf")
        case .spaceLens:    return Color(hex:"8b5cf6")
        case .cloudCleanup: return Color(hex:"38bdf8")
        case .myTools:      return Color(hex:"7b5cf0")
        case .myActivity:   return Color(hex:"7b5cf0")
        case .aiAssistant:  return Color(hex:"a78bfa")
        }
    }

    var isSeparatorBefore: Bool { self == .myTools || self == .aiAssistant }
}

// MARK: - ContentView

struct ContentView: View {
    @StateObject private var engine = CleanerEngine()
    @State private var selected: AppSection = .smartCare
    @State private var showResults = false
    @State private var searchText = ""

    var body: some View {
        #if os(macOS)
        ZStack {
            PremiumBackground(section: selected)
                .animation(.easeInOut(duration: 0.45), value: selected)
            HStack(spacing: 0) {
                sidebarView
                mainArea
            }
        }
        .frame(minWidth: 1180, minHeight: 760)
        .onChange(of: engine.lastToolScan) { _, new in
            guard let title = new else { return }
            // Map tool title -> app section and show results
            switch title {
            case "Malware Finder":
                selected = .protection
                showResults = false
            case "Login Items", "Background Items":
                selected = .performance
                showResults = false
            case "Large and Old Files", "Downloads", "Similar Images", "Duplicate Finder":
                selected = .myClutter
                showResults = true
            case "System Junk", "Privacy Items", "Trash Bins", "Mail Attachments", "App Leftovers", "Uninstaller":
                selected = .cleanup
                showResults = true
            case "Space Lens":
                selected = .spaceLens
                showResults = true
            // Cloud services should remain in Cloud Cleanup section
            case let s where s.localizedCaseInsensitiveContains("drive") || s.localizedCaseInsensitiveContains("dropbox") || s.localizedCaseInsensitiveContains("cloud"):
                selected = .cloudCleanup
                showResults = true
            case "Full Scan":
                selected = .smartCare
                showResults = false
            default:
                selected = .cleanup
                showResults = true
            }
        }
        #else
        mobileView
        #endif
    }

    // MARK: Sidebar
    private var sidebarView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 52)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(AppSection.allCases) { section in
                        if section.isSeparatorBefore {
                            Divider()
                                .background(Color.white.opacity(0.15))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                        }
                        SidebarItem(section: section, isSelected: selected == section)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
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
        .frame(width: 224)
        .background(
            LinearGradient(
                colors: [Color.black.opacity(0.42), Color.black.opacity(0.22)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay(Rectangle().fill(Color.white.opacity(0.08)).frame(width: 1), alignment: .trailing)
    }

    // MARK: Main Area
    private var mainArea: some View {
        Group {
            switch selected {
            case .smartCare:
                SmartCareDashboard(
                    engine: engine,
                    onRunSmartCare: runSmartCare,
                    onOpenSection: { section in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selected = section
                            showResults = section == .cleanup || section == .myClutter || section == .spaceLens
                        }
                    }
                )
            case .myTools:      MyToolsView(searchText: $searchText, engine: engine)
            case .myActivity:   MyActivityView()
            case .aiAssistant:  AIAssistantView(engine: engine)
            case .cloudCleanup: FunctionalCloudCleanupView(accentColor: selected.accentColor, engine: engine)
            case .performance:  PerformanceView(engine: engine)
            case .protection:   ProtectionView(engine: engine)
            case .spaceLens:    SpaceLensView(engine: engine)
            case .cleanup, .myClutter:
                ZStack(alignment: .bottom) {
                    if showResults && !filteredItems.isEmpty { resultsView } else { heroView }
                    scanButton.padding(.bottom, 28)
                }
            default:
                ZStack(alignment: .bottom) {
                    heroView
                    scanButton.padding(.bottom, 28)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: Hero
    private var heroView: some View {
        HStack(alignment: .center, spacing: 28) {
            ZStack {
                if engine.isScanning {
                    ProgressView().scaleEffect(2).tint(.white)
                } else {
                    HeroGem(section: selected, accent: selected.accentColor)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HeroInfoCard(
                section: selected,
                accent: selected.accentColor,
                scannedBytes: engine.scannedBytes,
                freedBytes: engine.freedBytes,
                itemCount: filteredItems.count
            )
            .frame(width: 340)
            .padding(.trailing, 42)
        }
        .padding(.leading, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: Results
    private var resultsView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(filteredItems.count) items · \(engine.scannedBytes.formatted(.byteCount(style: .file)))")
                    .font(.subheadline).foregroundStyle(.white.opacity(0.7))
                Spacer()
                Button("Clean All") { Task { await engine.clearAll() } }
                    .buttonStyle(PillButtonStyle(color: selected.accentColor))
                    .disabled(engine.isClearing)
            }
            .padding(.horizontal, 32).padding(.top, 24).padding(.bottom, 12)
            List(filteredItems) { item in
                ResultRow(item: item, accent: selected.accentColor)
                    .listRowBackground(Color.white.opacity(0.05))
                    .listRowSeparatorTint(.white.opacity(0.1))
            }
            .listStyle(.plain).scrollContentBackground(.hidden)
            Spacer().frame(height: 80)
        }
    }

    // MARK: Scan Button
    private var scanButton: some View {
        VStack(spacing: 8) {
            if engine.isScanning && !engine.scanProgress.isEmpty {
                Text(engine.scanProgress)
                    .font(.system(size: 11))
                    .foregroundStyle(.white.opacity(0.6))
            }
            Button {
                if showResults { showResults = false; engine.items = [] }
                else { Task { await engine.scan(); if !filteredItems.isEmpty { showResults = true } } }
            } label: {
                ZStack {
                    Circle()
                        .fill(selected.accentColor.opacity(0.18))
                        .frame(width: 92, height: 92)
                        .blur(radius: 10)
                    Circle()
                        .stroke(LinearGradient(colors: [Color.white.opacity(0.55), selected.accentColor.opacity(0.25)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                        .background(Circle().fill(selected.accentColor.opacity(0.72)))
                        .frame(width: 68, height: 68)
                    if engine.isScanning { ProgressView().tint(.white) }
                    else { Text(showResults ? "Rescan" : "Scan").font(.system(size: 15, weight: .semibold)).foregroundStyle(.white) }
                }
            }
            .buttonStyle(.plain)
            .disabled(engine.isScanning || engine.isClearing)
            .shadow(color: selected.accentColor.opacity(0.6), radius: 16, y: 4)
        }
    }

    private func runSmartCare() {
        Task {
            await engine.scan()
            await engine.scanLaunchAgents()
            await engine.scanLoginItems()
            showResults = false
            selected = .smartCare
        }
    }

    // MARK: Mobile
    private var mobileView: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: selected.gradientColors, startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                heroView
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Menu {
                        ForEach(AppSection.allCases) { s in Button(s.rawValue) { selected = s } }
                    } label: {
                        Label(selected.rawValue, systemImage: selected.sidebarIcon).foregroundStyle(.white)
                    }
                }
            }
        }
    }

    private var filteredItems: [CleanerEngine.CleanItem] {
        switch selected {
        case .cleanup:
            return engine.items.filter { [.userCache, .systemCache, .appSupportCache, .containerCache, .logs, .temp].contains($0.category) }
        case .myClutter:
            return engine.items.filter { [.largeFile, .downloads].contains($0.category) }
        case .spaceLens:
            return engine.items.filter { $0.category == .largeFile }
        default:
            return engine.items
        }
    }
}

// Simple setup chooser for Google Drive (desktop vs web)
struct GoogleDriveSetupView: View {
    let accentColor: Color
    var onChoice: (String) -> Void

    var body: some View {
        VStack(spacing: 18) {
            Text("Select Google Drive Setup")
                .font(.system(size: 20, weight: .semibold))
                .padding(.top, 12)

            VStack(spacing: 12) {
                Button(action: { onChoice("desktop") }) {
                    HStack(spacing: 12) {
                        Image(systemName: "desktopcomputer")
                            .font(.system(size: 28)).foregroundStyle(accentColor)
                        VStack(alignment: .leading) {
                            Text("Google Drive via desktop app").font(.headline).foregroundStyle(.primary)
                            Text("Select this if you use the desktop app to manage your cloud files on this Mac.")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding().background(RoundedRectangle(cornerRadius: 10).fill(Color(NSColor.windowBackgroundColor).opacity(0.06)))
                }

                Button(action: { onChoice("web") }) {
                    HStack(spacing: 12) {
                        Image(systemName: "globe")
                            .font(.system(size: 28)).foregroundStyle(accentColor)
                        VStack(alignment: .leading) {
                            Text("Google Drive via web app").font(.headline).foregroundStyle(.primary)
                            Text("Select this if you don't use the desktop app but want to manage your cloud files in the cloud.")
                                .font(.subheadline).foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding().background(RoundedRectangle(cornerRadius: 10).fill(Color(NSColor.windowBackgroundColor).opacity(0.06)))
                }
            }
            Spacer()
            HStack { Spacer(); Button("Cancel") { onChoice("") } }
        }
        .padding(20)
        .frame(width: 620, height: 320)
    }
}

// MARK: - Smart Care

struct SmartCareDashboard: View {
    @ObservedObject var engine: CleanerEngine
    let onRunSmartCare: () -> Void
    let onOpenSection: (AppSection) -> Void

    private var junkItems: [CleanerEngine.CleanItem] {
        engine.items.filter { [.userCache, .systemCache, .appSupportCache, .containerCache, .logs, .temp, .xcode, .devTools, .trash, .privacyTrace].contains($0.category) }
    }

    private var clutterItems: [CleanerEngine.CleanItem] {
        engine.items.filter { [.largeFile, .downloads].contains($0.category) }
    }

    private var junkBytes: Int64 {
        junkItems.reduce(0) { $0 + $1.size }
    }

    private var hasSmartCareData: Bool {
        !engine.items.isEmpty || !engine.launchAgents.isEmpty || !engine.loginItems.isEmpty
    }

    var body: some View {
        Group {
            if engine.isScanning || hasSmartCareData {
                taskDashboard
            } else {
                preScanHero
            }
        }
    }

    private var preScanHero: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .center, spacing: 72) {
                HeroGem(section: .smartCare, accent: AppSection.smartCare.accentColor)
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Smart Care")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundStyle(.white)
                        Text("Run a full system scan and fix issues automatically.")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(.white.opacity(0.66))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 360)
                    }

                    VStack(alignment: .leading, spacing: 18) {
                        FeatureRow(icon: "sparkles", label: "Smart Scan", accent: AppSection.smartCare.accentColor)
                        FeatureRow(icon: "shield.checkered", label: "Quick Fix", accent: AppSection.smartCare.accentColor)
                        FeatureRow(icon: "chart.bar.fill", label: "Health Report", accent: AppSection.smartCare.accentColor)
                    }
                }
                .frame(width: 410, alignment: .leading)
                .padding(.trailing, 80)
            }
            .padding(.leading, 56)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Button {
                onRunSmartCare()
            } label: {
                ZStack {
                    Circle()
                        .fill(AppSection.smartCare.accentColor.opacity(0.18))
                        .frame(width: 104, height: 104)
                        .blur(radius: 12)
                    Circle()
                        .stroke(LinearGradient(colors: [Color.white.opacity(0.55), AppSection.smartCare.accentColor.opacity(0.22)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                        .background(Circle().fill(AppSection.smartCare.accentColor.opacity(0.78)))
                        .frame(width: 76, height: 76)
                    Text("Scan")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            .buttonStyle(.plain)
            .shadow(color: AppSection.smartCare.accentColor.opacity(0.64), radius: 18, y: 6)
            .padding(.bottom, 34)
        }
    }

    private var taskDashboard: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    onRunSmartCare()
                } label: {
                    Label(engine.isScanning ? "Scanning..." : "Run Smart Care", systemImage: engine.isScanning ? "arrow.triangle.2.circlepath" : "sparkles")
                }
                .buttonStyle(SmartCareHeaderButtonStyle())
                .disabled(engine.isScanning)

                Spacer()

                Text("Smart Care")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white.opacity(0.72))

            }
            .padding(.horizontal, 34)
            .padding(.top, 26)

            Text(engine.items.isEmpty && engine.launchAgents.isEmpty && engine.loginItems.isEmpty ? "Run one smart scan across cleanup, protection, performance, apps, and clutter." : "Your tasks are ready to run. Look what we found:")
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 66)
                .padding(.bottom, 34)
                .frame(maxWidth: 880)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 18),
                    GridItem(.flexible(), spacing: 18),
                    GridItem(.flexible(), spacing: 18)
                ],
                spacing: 18
            ) {
                SmartCareTaskCard(
                    title: "Cleanup",
                    value: junkBytes > 0 ? junkBytes.formatted(.byteCount(style: .file)) + " of junk" : "Ready to scan",
                    detail: "to clean",
                    icon: "trash.fill",
                    accent: Color(hex: "43a047"),
                    section: .cleanup,
                    isChecked: !junkItems.isEmpty,
                    action: onOpenSection
                )

                SmartCareTaskCard(
                    title: "Protection",
                    value: engine.launchAgents.isEmpty ? "No threats" : "\(engine.launchAgents.count) threats",
                    detail: "to remove",
                    icon: "hand.raised.fill",
                    accent: Color(hex: "e91e8c"),
                    section: .protection,
                    isChecked: engine.launchAgents.isEmpty && !engine.items.isEmpty,
                    action: onOpenSection
                )

                SmartCareTaskCard(
                    title: "Performance",
                    value: engine.loginItems.isEmpty ? "Ready to review" : "\(engine.loginItems.count) items",
                    detail: "to review",
                    icon: "bolt.fill",
                    accent: Color(hex: "fb8c00"),
                    section: .performance,
                    action: onOpenSection
                )

                SmartCareTaskCard(
                    title: "Applications",
                    value: "No vital updates",
                    detail: "to install",
                    icon: "xmark.app.fill",
                    accent: Color(hex: "2979ff"),
                    section: .applications,
                    span: 1.5,
                    action: onOpenSection
                )

                SmartCareTaskCard(
                    title: "My Clutter",
                    value: clutterItems.isEmpty ? "No duplicate downloads" : "\(clutterItems.count) files",
                    detail: "to review",
                    icon: "folder.fill",
                    accent: Color(hex: "2dd4bf"),
                    section: .myClutter,
                    span: 1.5,
                    action: onOpenSection
                )
            }
            .padding(.horizontal, 34)

            Spacer(minLength: 24)
        }
    }
}

private struct SmartCareTaskCard: View {
    let title: String
    let value: String
    let detail: String
    let icon: String
    let accent: Color
    let section: AppSection
    var isChecked = false
    var span: CGFloat = 1
    let action: (AppSection) -> Void

    var body: some View {
        Button {
            action(section)
        } label: {
            ZStack(alignment: .topTrailing) {
                LinearGradient(
                    colors: [accent.opacity(0.34), Color(hex: "6d28d9").opacity(0.28), Color.black.opacity(0.08)],
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )

                IconShowpiece(icon: icon, accent: accent)
                    .offset(x: 28, y: -26)

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 10) {
                        if isChecked {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.white.opacity(0.16), in: RoundedRectangle(cornerRadius: 8))
                        }

                        Text(title)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(.white.opacity(0.72))
                    }

                    Spacer()

                    Text(value)
                        .font(.system(size: 31, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.72)
                    Text(detail)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.62))

                    HStack {
                        Spacer()
                        Text("Review")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.16), in: RoundedRectangle(cornerRadius: 8))
                    }
                    .opacity(section == .protection && value == "No threats" ? 0 : 1)
                }
                .padding(22)
            }
            .frame(height: span > 1 ? 214 : 184)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.white.opacity(0.16), lineWidth: 1)
            )
            .shadow(color: accent.opacity(0.20), radius: 24, y: 14)
        }
        .buttonStyle(.plain)
        .gridCellColumns(span > 1 ? 2 : 1)
    }
}

private struct IconShowpiece: View {
    let icon: String
    let accent: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(LinearGradient(colors: [accent.opacity(0.78), Color.white.opacity(0.22)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 124, height: 112)
                .rotationEffect(.degrees(-10))
                .shadow(color: Color.black.opacity(0.26), radius: 16, y: 10)
            Image(systemName: icon)
                .font(.system(size: 50, weight: .bold))
                .foregroundStyle(.white.opacity(0.86))
                .rotationEffect(.degrees(-10))
        }
    }
}

private struct SmartCareHeaderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.white.opacity(0.75))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Color.white.opacity(configuration.isPressed ? 0.16 : 0.08), in: Capsule())
    }
}

// MARK: - My Tools View

struct MyToolsView: View {
    @Binding var searchText: String
    @ObservedObject var engine: CleanerEngine
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var filtered: [ToolCard] {
        searchText.isEmpty ? allToolCards : allToolCards.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.description.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("My Tools")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Your go-to tools for keeping your Mac clean, safe and\nrunning smoothly.")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.65))
                }
                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white.opacity(0.5))
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
                .frame(width: 220)
            }
            .padding(.horizontal, 28)
            .padding(.top, 28)
            .padding(.bottom, 20)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filtered) { card in
                        ToolCardView(card: card, engine: engine)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 28)
            }
        }
    }
}

struct ToolCardView: View {
    let card: ToolCard
    @ObservedObject var engine: CleanerEngine

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Circle()
                    .fill(card.iconColor)
                    .frame(width: 44, height: 44)
                Image(systemName: card.icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
            }
            .padding(.top, 20)
            .padding(.leading, 20)

            Text(card.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.white)
                .padding(.top, 14)
                .padding(.horizontal, 20)

            Text(card.description)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.6))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 6)
                .padding(.horizontal, 20)

            // Per-tool status / last result summary
            HStack(spacing: 8) {
                if engine.currentToolScan == card.title {
                    ProgressView().scaleEffect(0.6).tint(.white)
                    Text("Scanning...").font(.system(size: 12)).foregroundStyle(.white.opacity(0.7))
                } else if engine.lastToolScan == card.title {
                    Text("\(engine.lastToolCount) items found").font(.system(size: 12)).foregroundStyle(.white.opacity(0.7))
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)

            Spacer(minLength: 16)

            HStack {
                if card.hasLocationPicker {
                    HStack(spacing: 4) {
                        Image(systemName: "folder.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(.white.opacity(0.6))
                        Text("YashB")
                            .font(.system(size: 12))
                            .foregroundStyle(.white.opacity(0.7))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
                Spacer()
                Button("Scan") {
                    print("[UI] Tool Scan button tapped: \(card.title)")
                    switch card.title {
                    case "Privacy Items":
                        Task { await engine.scanPrivacyItems() }
                    case "Large and Old Files":
                        Task { await engine.scanLargeFiles() }
                    case "System Junk":
                        Task { await engine.scanSystemJunk() }
                    case "Malware Finder":
                        Task { await engine.scanLaunchAgents() }
                    case "Login Items":
                        Task { await engine.scanLoginItems() }
                    case "Downloads":
                        Task { await engine.scanDownloads() }
                    case "App Leftovers":
                        Task { await engine.scanAppLeftovers() }
                    case "Trash Bins":
                        Task { await engine.scanTrash() }
                    case "Mail Attachments":
                        Task { await engine.scanMailAttachments() }
                    case "Time Machine Snapshot":
                        // No destructive action here; list snapshots if possible via a background task
                        Task { await engine.scan() }
                    case "Background Items":
                        Task { await engine.scanLoginItems() }
                    case "Application Permissions":
                        // Permissions are managed via system settings; perform a lightweight scan
                        Task { await engine.scan() }
                    case "Similar Images", "Duplicate Finder":
                        // These require specialized algorithms / location picker; fall back to general scan
                        Task { await engine.scan() }
                    default:
                        Task { await engine.scan() }
                    }
                }
                .buttonStyle(CardScanButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 200, alignment: .leading)
        .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Cloud Cleanup View

struct CloudCleanupView: View {
    let accentColor: Color
    @ObservedObject var engine: CleanerEngine

    @State private var showingGoogleSetup = false
    @State private var showingServiceComingSoon: (Bool, String) = (false, "")

    let services: [(service: CleanerEngine.CloudService, icon: String, color: Color, name: String)] = [
        (.iCloud,   "icloud.fill",   Color(hex:"3b82f6"), "Connect iCloud"),
        (.googleDrive, "g.circle.fill", Color(hex:"ea4335"), "Connect Google Drive"),
        (.oneDrive,  "cloud.fill",    Color(hex:"0078d4"), "Connect OneDrive"),
        (.dropbox,   "drop.fill",     Color(hex:"0061ff"), "Connect Dropbox"),
    ]

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(spacing: 0) {
                HeroGem(section: .cloudCleanup, accent: accentColor)
                Text("Secure connection")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.top, 12)
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cloud Cleanup")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(.white)
                    Text("Clean up your cloud storage and free up space online.")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.7))
                        .frame(maxWidth: 280)
                }
                VStack(spacing: 12) {
                    ForEach(services, id: \.name) { svc in
                        Button(action: {
                            // For Google Drive prefer showing the setup chooser (desktop vs web)
                            if svc.service == .googleDrive {
                                showingGoogleSetup = true
                                return
                            }
                            // Trigger a best-effort local scan of the cloud sync folder
                            Task {
                                await engine.scanCloud(svc.service)
                            }
                        }) {
                            HStack(spacing: 14) {
                                Image(systemName: svc.icon)
                                    .font(.system(size: 18))
                                    .foregroundStyle(svc.color)
                                    .frame(width: 28)
                                Text(svc.name)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.white)
                                Spacer()
                                if engine.isScanning && engine.currentToolScan == svc.service.displayName {
                                    ProgressView().tint(.white).scaleEffect(0.8)
                                }
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: 280)
                        .disabled(engine.isScanning)
                    }
                }

                // Google Drive setup modal (desktop app vs web app)
                .sheet(isPresented: $showingGoogleSetup) {
                    GoogleDriveSetupView(accentColor: accentColor) { choice in
                        // choice: "desktop" or "web"
                        if choice == "desktop" {
                            // Present folder picker and scan selected folder
                            #if os(macOS)
                            let panel = NSOpenPanel()
                            panel.canChooseDirectories = true
                            panel.canChooseFiles = false
                            panel.allowsMultipleSelection = false
                            panel.title = "Select your Google Drive folder"
                            panel.begin { resp in
                                guard resp == .OK, let url = panel.urls.first else { return }
                                Task { await engine.scanCloud(folderURL: url, displayName: "Google Drive (custom)") }
                            }
                            #endif
                        } else {
                            // Web/API flow - not implemented yet; show a temporary message
                            showingServiceComingSoon = (true, "Google Drive (web)")
                        }
                        showingGoogleSetup = false
                    }
                }

                // Simple alert for services that require OAuth (placeholder)
                .alert(isPresented: $showingServiceComingSoon.0) {
                    Alert(title: Text("Coming soon"), message: Text("Remote/cloud API integration for \(showingServiceComingSoon.1) is not yet implemented. I can implement OAuth flows next if you want."), dismissButton: .default(Text("OK")))
                }

                // If the engine has results from a cloud scan, show a quick action
                if !engine.items.isEmpty && engine.lastToolScan?.contains("Drive") == true || engine.lastToolScan == "iCloud Drive" || engine.lastToolScan == "Dropbox" {
                    HStack {
                        Text("\(engine.items.count) items · \(engine.scannedBytes.formatted(.byteCount(style: .file)))")
                            .font(.subheadline).foregroundStyle(.white.opacity(0.7))
                        Spacer()
                        Button("Clean All") { Task { await engine.clearAll() } }
                            .buttonStyle(PillButtonStyle(color: accentColor))
                            .disabled(engine.isClearing)
                    }
                    .frame(maxWidth: 280)
                    .padding(.top, 8)
                }

                Spacer()
            }
            .frame(width: 320)
            .padding(.trailing, 48)
            .padding(.top, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FunctionalCloudCleanupView: View {
    let accentColor: Color
    @ObservedObject var engine: CleanerEngine

    @State private var selectedService: CleanerEngine.CloudService?
    @State private var selectedFolderName: String?

    private let services: [(service: CleanerEngine.CloudService, icon: String, color: Color, title: String, subtitle: String)] = [
        (.iCloud, "icloud.fill", Color(hex:"3b82f6"), "iCloud Drive", "Scan local iCloud Drive files"),
        (.googleDrive, "g.circle.fill", Color(hex:"ea4335"), "Google Drive", "Find large synced Drive files"),
        (.oneDrive, "cloud.fill", Color(hex:"0078d4"), "OneDrive", "Review local OneDrive storage"),
        (.dropbox, "drop.fill", Color(hex:"0061ff"), "Dropbox", "Clean synced Dropbox files"),
    ]

    private var isCloudScan: Bool {
        guard let lastToolScan = engine.lastToolScan else { return false }
        return lastToolScan.localizedCaseInsensitiveContains("drive")
            || lastToolScan.localizedCaseInsensitiveContains("dropbox")
            || lastToolScan.localizedCaseInsensitiveContains("cloud")
            || lastToolScan.localizedCaseInsensitiveContains("onedrive")
            || lastToolScan.localizedCaseInsensitiveContains("icloud")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            serviceGrid

            if engine.isScanning {
                scanningState
            } else if isCloudScan {
                cloudResults
            } else {
                CloudEmptyState(accentColor: accentColor)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var header: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Cloud Cleanup")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                Text("Scan local cloud sync folders and remove files you no longer need.")
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.65))
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            Button {
                chooseCloudFolder()
            } label: {
                Label("Choose Folder", systemImage: "folder.badge.plus")
            }
            .buttonStyle(PillButtonStyle(color: accentColor))
            .disabled(engine.isScanning)
        }
        .padding(.horizontal, 32)
        .padding(.top, 28)
        .padding(.bottom, 20)
    }

    private var serviceGrid: some View {
        HStack(spacing: 16) {
            ForEach(services, id: \.title) { service in
                CloudServiceCard(
                    icon: service.icon,
                    color: service.color,
                    title: service.title,
                    subtitle: service.subtitle,
                    isSelected: selectedService == service.service,
                    isScanning: engine.isScanning && engine.currentToolScan == service.service.displayName
                ) {
                    selectedService = service.service
                    selectedFolderName = nil
                    Task { await engine.scanCloud(service.service) }
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 20)
    }

    private var scanningState: some View {
        VStack(spacing: 12) {
            Spacer()
            ProgressView().tint(.white).scaleEffect(1.5)
            Text(engine.scanProgress.isEmpty ? "Scanning cloud storage..." : engine.scanProgress)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white.opacity(0.65))
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var cloudResults: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(engine.items.isEmpty ? "No large cloud files found" : "\(engine.items.count) cloud items found")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                    Text(selectedFolderName ?? engine.lastToolScan ?? "Cloud storage")
                        .font(.system(size: 12))
                        .foregroundStyle(.white.opacity(0.52))
                }
                Spacer()
                Text(engine.scannedBytes.formatted(.byteCount(style: .file)))
                    .font(.system(size: 15, weight: .semibold).monospacedDigit())
                    .foregroundStyle(.white.opacity(0.72))
                Button("Clean All") {
                    Task { await engine.clear(items: engine.items) }
                }
                .buttonStyle(PillButtonStyle(color: accentColor))
                .disabled(engine.items.isEmpty || engine.isClearing)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 12)

            if engine.items.isEmpty {
                Spacer()
                CloudEmptyState(title: "Cloud storage looks clean", subtitle: "FreeUp did not find cloud files over 10 MB in the selected location.", accentColor: accentColor)
                Spacer()
            } else {
                List(engine.items) { item in
                    ResultRow(item: item, accent: accentColor)
                        .listRowBackground(Color.white.opacity(0.05))
                        .listRowSeparatorTint(.white.opacity(0.1))
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }

    private func chooseCloudFolder() {
        #if os(macOS)
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.title = "Choose a cloud folder to scan"
        panel.message = "Select a local iCloud, Google Drive, OneDrive, Dropbox, or synced cloud folder."
        panel.begin { response in
            guard response == .OK, let url = panel.urls.first else { return }
            selectedService = nil
            selectedFolderName = url.lastPathComponent
            Task { await engine.scanCloud(folderURL: url, displayName: url.lastPathComponent) }
        }
        #endif
    }
}

private struct CloudServiceCard: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String
    let isSelected: Bool
    let isScanning: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(color)
                        .frame(width: 42, height: 42)
                        .background(color.opacity(0.16), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    Spacer()
                    if isScanning {
                        ProgressView().tint(.white).scaleEffect(0.8)
                    } else if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(color)
                    }
                }
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.56))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 132, alignment: .topLeading)
            .background(
                LinearGradient(colors: [Color.white.opacity(isSelected ? 0.16 : 0.09), color.opacity(isSelected ? 0.16 : 0.06)], startPoint: .topLeading, endPoint: .bottomTrailing),
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(isSelected ? color.opacity(0.55) : Color.white.opacity(0.12), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .disabled(isScanning)
    }
}

private struct CloudEmptyState: View {
    var title = "Choose a cloud service"
    var subtitle = "FreeUp scans local synced cloud folders. For unsynced online-only files, download them or choose the synced folder first."
    let accentColor: Color

    var body: some View {
        VStack(spacing: 14) {
            Spacer()
            HeroGem(section: .cloudCleanup, accent: accentColor)
                .scaleEffect(0.62)
                .frame(height: 210)
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
            Text(subtitle)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.58))
                .multilineTextAlignment(.center)
                .frame(maxWidth: 440)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - My Activity View

struct MyActivityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My Activity")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 28)
                .padding(.top, 28)
                .padding(.bottom, 20)

            HStack(alignment: .top, spacing: 16) {
                // Mac Health card (large)
                MacHealthCard()
                    .frame(maxWidth: .infinity)

                // Right column: 2x2 grid
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        ActivityInfoCard(icon: "magnifyingglass.circle.fill", message: "Clean up storage and watch your free gigabytes add up.", buttonLabel: "Go to Smart Care")
                        ActivityInfoCard(icon: "clock.fill", message: "Start using FreeUp to see your recent time saved.", buttonLabel: "Go to Smart Care")
                    }
                    HStack(spacing: 16) {
                        ActivityInfoCard(icon: "hand.raised.fill", iconColor: Color(hex:"e91e63"), message: "To view your Mac's protection you need to upgrade your plan.", buttonLabel: nil)
                        ActivityInfoCard(icon: "cloud.fill", iconColor: Color(hex:"3b82f6"), message: "To clean cloud storage you need to upgrade your plan.", buttonLabel: nil)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 28)

            // Recommendations
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("5 Recommendations")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                    Spacer()
                    Button("View All") {}
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.7))
                        .buttonStyle(.plain)
                }
                RecommendationCard(
                    icon: "lock.open.fill",
                    iconColor: Color(hex:"f57c00"),
                    title: "Unlock FreeUp",
                    description: "Activate your copy to take advantage of all FreeUp's features."
                )
            }
            .padding(.horizontal, 28)
            .padding(.top, 20)

            Spacer()
        }
    }
}

struct MacHealthCard: View {
    @State private var totalBytes: Int64 = 0
    @State private var usedBytes: Int64 = 0
    @State private var volumeName: String = "Macintosh HD"

    private var usedFraction: Double {
        totalBytes > 0 ? Double(usedBytes) / Double(totalBytes) : 0
    }
    private var healthLabel: String {
        switch usedFraction {
        case ..<0.7:  return "Excellent"
        case ..<0.85: return "Good"
        case ..<0.95: return "Fair"
        default:      return "Critical"
        }
    }
    private var healthColor: Color {
        switch usedFraction {
        case ..<0.7:  return Color(hex:"00e5ff")
        case ..<0.85: return Color(hex:"4ade80")
        case ..<0.95: return Color(hex:"fbbf24")
        default:      return Color(hex:"f87171")
        }
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(colors: [Color(hex:"0d1b4a"), Color(hex:"0a2a5e")], startPoint: .topLeading, endPoint: .bottomTrailing))
            Circle()
                .stroke(AngularGradient(colors: [healthColor, Color(hex:"0d47a1"), healthColor], center: .center), lineWidth: 6)
                .frame(width: 160, height: 160)
                .blur(radius: 4)
                .offset(x: 80, y: -20)
                .clipped()
            VStack(alignment: .leading, spacing: 4) {
                Text("Mac Health:").font(.system(size: 13)).foregroundStyle(.white.opacity(0.7))
                HStack(spacing: 6) {
                    Text(healthLabel).font(.system(size: 22, weight: .bold)).foregroundStyle(healthColor)
                    Image(systemName: "info.circle").font(.system(size: 13)).foregroundStyle(.white.opacity(0.4))
                }
                Text(volumeName).font(.system(size: 12)).foregroundStyle(.white.opacity(0.5))
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(volumeName).font(.system(size: 13, weight: .semibold)).foregroundStyle(.white)
                        Spacer()
                        Text("\(ByteCountFormatter.string(fromByteCount: usedBytes, countStyle: .file)) of \(ByteCountFormatter.string(fromByteCount: totalBytes, countStyle: .file)) used")
                            .font(.system(size: 12)).foregroundStyle(.white.opacity(0.6))
                    }
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.white.opacity(0.15)).frame(height: 6)
                            Capsule().fill(healthColor.opacity(0.8)).frame(width: geo.size.width * usedFraction, height: 6)
                        }
                    }
                    .frame(height: 6)
                }
            }
            .padding(20)
        }
        .frame(height: 200)
        .task { loadDiskInfo() }
    }

    private func loadDiskInfo() {
        let url = URL(fileURLWithPath: "/")
        if let vals = try? url.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityKey, .volumeNameKey]) {
            totalBytes = Int64(vals.volumeTotalCapacity ?? 0)
            usedBytes = totalBytes - Int64(vals.volumeAvailableCapacity ?? 0)
            volumeName = vals.volumeName ?? "Macintosh HD"
        }
    }
}

struct ActivityInfoCard: View {
    let icon: String
    var iconColor: Color = Color(hex:"7b5cf0")
    let message: String
    let buttonLabel: String?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 36))
                .foregroundStyle(iconColor.opacity(0.7))
            Text(message)
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.65))
                .multilineTextAlignment(.center)
            if let label = buttonLabel {
                Button(label) {}
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12).padding(.vertical, 7)
                    .background(Color.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 8))
                    .buttonStyle(.plain)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 140)
        .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
        .overlay(alignment: .topTrailing) {
            Image(systemName: "info.circle")
                .font(.system(size: 12))
                .foregroundStyle(.white.opacity(0.3))
                .padding(10)
        }
    }
}

struct RecommendationCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(iconColor).frame(width: 44, height: 44)
                Image(systemName: icon).font(.system(size: 20)).foregroundStyle(.white)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                Text(description).font(.system(size: 12)).foregroundStyle(.white.opacity(0.6))
            }
            Spacer()
        }
        .padding(16)
        .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 14))
    }
}

// MARK: - Shared Components

private struct PremiumBackground: View {
    let section: AppSection

    var body: some View {
        ZStack {
            LinearGradient(colors: section.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
            LinearGradient(
                colors: [Color.black.opacity(0.08), Color.black.opacity(0.46)],
                startPoint: .top,
                endPoint: .bottom
            )
            Circle()
                .fill(section.accentColor.opacity(0.28))
                .frame(width: 420, height: 420)
                .blur(radius: 70)
                .offset(x: -260, y: -210)
            Circle()
                .fill(Color(hex: "22d3ee").opacity(0.12))
                .frame(width: 520, height: 520)
                .blur(radius: 88)
                .offset(x: 340, y: 250)
            RadialGrid()
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
                .frame(width: 620, height: 620)
                .offset(x: 88, y: 10)
        }
        .ignoresSafeArea()
    }
}

private struct RadialGrid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let maxRadius = min(rect.width, rect.height) * 0.48

        for index in 1...5 {
            let radius = maxRadius * CGFloat(index) / 5
            path.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        }

        for index in 0..<12 {
            let angle = CGFloat(index) * .pi / 6
            let end = CGPoint(x: center.x + cos(angle) * maxRadius, y: center.y + sin(angle) * maxRadius)
            path.move(to: center)
            path.addLine(to: end)
        }

        return path
    }
}

private struct HeroInfoCard: View {
    let section: AppSection
    let accent: Color
    let scannedBytes: Int64
    let freedBytes: Int64
    let itemCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            VStack(alignment: .leading, spacing: 10) {
                Text(section.rawValue)
                    .font(.system(size: 38, weight: .bold))
                    .foregroundStyle(.white)
                Text(section.subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.68))
                    .fixedSize(horizontal: false, vertical: true)
            }

            HStack(spacing: 10) {
                MetricPill(title: "Found", value: "\(itemCount)", accent: accent)
                MetricPill(title: "Scanned", value: scannedBytes.formatted(.byteCount(style: .file)), accent: Color(hex: "22d3ee"))
            }

            VStack(alignment: .leading, spacing: 12) {
                ForEach(section.features, id: \.label) { feature in
                    FeatureRow(icon: feature.icon, label: feature.label, accent: accent)
                }
                if section.features.isEmpty {
                    FeatureRow(icon: section.heroIcon, label: freedBytes > 0 ? "Recovered \(freedBytes.formatted(.byteCount(style: .file)))" : "Ready for action", accent: accent)
                }
            }

            Spacer(minLength: 0)
        }
        .padding(26)
        .frame(maxHeight: 420, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(LinearGradient(colors: [Color.white.opacity(0.16), Color.white.opacity(0.055)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(LinearGradient(colors: [Color.white.opacity(0.34), Color.white.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.28), radius: 34, y: 18)
    }
}

private struct MetricPill: View {
    let title: String
    let value: String
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title.uppercased())
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(.white.opacity(0.48))
            Text(value)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.72)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.16), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(accent.opacity(0.32), lineWidth: 1))
    }
}

private struct SidebarItem: View {
    let section: AppSection
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 10) {
            // Use custom FreeUp icons for primary sections; fall back to SF Symbols for anything else
            Group {
                if section == .smartCare {
                    FreeUpLogoView(accent: isSelected ? .white : section.accentColor)
                        .frame(width: 18, height: 18)
                } else if section == .protection {
                    IconShield(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .cleanup {
                    IconTrash(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .performance {
                    IconGear(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .applications {
                    IconFolder(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .myClutter {
                    IconFolder(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .spaceLens {
                    IconSparkle(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .cloudCleanup {
                    IconDownload(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .myTools {
                    IconGear(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .myActivity {
                    IconSparkle(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else if section == .aiAssistant {
                    IconSparkle(accent: isSelected ? .white : section.accentColor).frame(width: 16, height: 16)
                } else {
                    Image(systemName: section.sidebarIcon)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(isSelected ? .white : .white.opacity(0.55))
                        .frame(width: 20)
                }
            }
            .frame(width: 20)

            Text(section.rawValue)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? .white : .white.opacity(0.65))
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(
            Group {
                if isSelected {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(LinearGradient(colors: [section.accentColor.opacity(0.34), Color.white.opacity(0.10)], startPoint: .leading, endPoint: .trailing))
                }
            }
        )
        .overlay(
            Group {
                if isSelected {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.white.opacity(0.18), lineWidth: 1)
                }
            }
        )
        .padding(.horizontal, 10)
        .contentShape(Rectangle())
    }
}

private struct HeroGem: View {
    let section: AppSection
    let accent: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(AngularGradient(colors: [accent.opacity(0.05), accent.opacity(0.7), Color(hex: "22d3ee").opacity(0.45), accent.opacity(0.05)], center: .center), lineWidth: 2)
                .frame(width: 360, height: 360)
                .blur(radius: 0.6)
            RoundedRectangle(cornerRadius: 82, style: .continuous)
                .fill(accent.opacity(0.16))
                .frame(width: 330, height: 330)
                .blur(radius: 34)
            RoundedRectangle(cornerRadius: 58, style: .continuous)
                .fill(LinearGradient(colors: [Color.white.opacity(0.24), accent.opacity(0.42), Color.black.opacity(0.10)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 254, height: 254)
                .overlay(
                    RoundedRectangle(cornerRadius: 58, style: .continuous)
                        .stroke(LinearGradient(colors: [Color.white.opacity(0.55), Color.white.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                )
                .shadow(color: accent.opacity(0.55), radius: 52, y: 26)
            Circle()
                .fill(Color.white.opacity(0.14))
                .frame(width: 96, height: 96)
                .blur(radius: 18)
                .offset(x: -86, y: -88)

            // Use FreeUp custom icons for the main hero when available
            switch section {
            case .smartCare:
                FreeUpLogoView(accent: accent)
                    .frame(width: 140, height: 140)
            case .protection:
                IconShield(accent: .white).frame(width: 120, height: 120)
            case .cleanup:
                IconTrash(accent: .white).frame(width: 120, height: 120)
            case .performance:
                IconGear(accent: .white).frame(width: 120, height: 120)
            case .applications:
                IconFolder(accent: .white).frame(width: 120, height: 120)
            case .myClutter:
                IconFolder(accent: .white).frame(width: 120, height: 120)
            case .spaceLens:
                IconSparkle(accent: .white).frame(width: 120, height: 120)
            case .cloudCleanup:
                IconDownload(accent: .white).frame(width: 120, height: 120)
            case .myTools:
                IconGear(accent: .white).frame(width: 120, height: 120)
            case .myActivity:
                IconSparkle(accent: .white).frame(width: 120, height: 120)
            case .aiAssistant:
                IconSparkle(accent: .white).frame(width: 120, height: 120)
            }
        }
    }
}

private struct FeatureRow: View {
    let icon: String
    let label: String
    let accent: Color

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .fill(LinearGradient(colors: [accent.opacity(0.42), Color.white.opacity(0.10)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 38, height: 38)
                    .overlay(RoundedRectangle(cornerRadius: 11, style: .continuous).stroke(Color.white.opacity(0.16), lineWidth: 1))
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
            }
            Text(label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white.opacity(0.92))
        }
    }
}

private struct ResultRow: View {
    let item: CleanerEngine.CleanItem
    let accent: Color

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle().fill(item.category.color.opacity(0.2)).frame(width: 28, height: 28)
                Image(systemName: item.category.icon)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(item.category.color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(item.url.lastPathComponent).foregroundStyle(.white).lineLimit(1)
                Text(item.category.rawValue + " · " + item.url.deletingLastPathComponent().path)
                    .font(.caption).foregroundStyle(.white.opacity(0.45)).lineLimit(1)
            }
            Spacer()
            Text(item.size.formatted(.byteCount(style: .file)))
                .font(.subheadline.monospacedDigit()).foregroundStyle(.white.opacity(0.7))
        }
        .padding(.vertical, 4)
    }
}

private struct PillButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 16).padding(.vertical, 7)
            .background(color.opacity(configuration.isPressed ? 0.5 : 0.7), in: Capsule())
    }
}

struct CardScanButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.primary)
            .padding(.horizontal, 18).padding(.vertical, 7)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

// MARK: - Helpers

extension Color {
    init(hex: String) {
        let v = UInt64(hex, radix: 16) ?? 0
        let r = Double((v >> 16) & 0xff) / 255
        let g = Double((v >> 8) & 0xff) / 255
        let b = Double(v & 0xff) / 255
        self.init(red: r, green: g, blue: b)
    }
}

extension CleanerEngine.CleanItem.Category {
    var icon: String {
        switch self {
        case .userCache:       return "internaldrive"
        case .systemCache:     return "server.rack"
        case .appSupportCache: return "app.badge"
        case .containerCache:  return "shippingbox"
        case .logs:            return "doc.text"
        case .temp:            return "clock"
        case .xcode:           return "hammer"
        case .devTools:        return "terminal"
        case .trash:           return "trash"
        case .largeFile:       return "doc.zipper"
        case .downloads:       return "arrow.down.circle"
        case .loginItems:      return "power"
        case .appLeftovers:    return "puzzlepiece"
        case .privacyTrace:    return "eye.slash"
        }
    }

    var color: Color {
        switch self {
        case .userCache:       return Color(hex:"3b82f6")
        case .systemCache:     return Color(hex:"6366f1")
        case .appSupportCache: return Color(hex:"8b5cf6")
        case .containerCache:  return Color(hex:"a855f7")
        case .logs:            return Color(hex:"f59e0b")
        case .temp:            return Color(hex:"64748b")
        case .xcode:           return Color(hex:"0ea5e9")
        case .devTools:        return Color(hex:"10b981")
        case .trash:           return Color(hex:"ef4444")
        case .largeFile:       return Color(hex:"f97316")
        case .downloads:       return Color(hex:"22c55e")
        case .loginItems:      return Color(hex:"fb923c")
        case .appLeftovers:    return Color(hex:"e879f9")
        case .privacyTrace:    return Color(hex:"ec4899")
        }
    }
}

// MARK: - Performance View

struct PerformanceView: View {
    @ObservedObject var engine: CleanerEngine
    @State private var scanned = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Performance").font(.system(size: 34, weight: .bold)).foregroundStyle(.white)
                    Text("Manage what runs at startup to speed up your Mac.")
                        .font(.system(size: 14)).foregroundStyle(.white.opacity(0.65))
                }
                Spacer()
                Button(scanned ? "Rescan" : "Scan") {
                    Task { await engine.scanLoginItems(); scanned = true }
                }
                .buttonStyle(PillButtonStyle(color: Color(hex:"f97316")))
            }
            .padding(.horizontal, 28).padding(.top, 28).padding(.bottom, 20)

            if engine.isScanning {
                Spacer()
                HStack { Spacer(); ProgressView().tint(.white).scaleEffect(1.5); Spacer() }
                Spacer()
            } else if engine.loginItems.isEmpty && scanned {
                Spacer()
                HStack { Spacer(); Text("No login items found.").foregroundStyle(.white.opacity(0.5)); Spacer() }
                Spacer()
            } else {
                List {
                    ForEach(engine.loginItems) { item in
                        HStack(spacing: 14) {
                            Image(systemName: "power.circle.fill")
                                .font(.system(size: 22))
                                .foregroundStyle(Color(hex:"fb923c"))
                            VStack(alignment: .leading, spacing: 3) {
                                Text(item.name).font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                                Text(item.path.isEmpty ? "Unknown path" : item.path)
                                    .font(.caption).foregroundStyle(.white.opacity(0.45)).lineLimit(1)
                            }
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { item.enabled },
                                set: { _ in engine.toggleLoginItem(item) }
                            ))
                            .toggleStyle(.switch)
                            .tint(Color(hex:"f97316"))
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(Color.white.opacity(0.05))
                        .listRowSeparatorTint(.white.opacity(0.1))
                    }
                }
                .listStyle(.plain).scrollContentBackground(.hidden)
            }
        }
    }
}

// MARK: - Protection View

struct ProtectionView: View {
    @ObservedObject var engine: CleanerEngine
    @State private var scanned = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Protection").font(.system(size: 34, weight: .bold)).foregroundStyle(.white)
                    Text("Scan for malware, adware, and suspicious launch agents.")
                        .font(.system(size: 14)).foregroundStyle(.white.opacity(0.65))
                }
                Spacer()
                Button(scanned ? "Rescan" : "Scan") {
                    Task { await engine.scanLaunchAgents(); scanned = true }
                }
                .buttonStyle(PillButtonStyle(color: Color(hex:"ec4899")))
            }
            .padding(.horizontal, 28).padding(.top, 28).padding(.bottom, 20)

            if engine.isScanning {
                Spacer()
                HStack { Spacer(); ProgressView().tint(.white).scaleEffect(1.5); Spacer() }
                Spacer()
            } else if scanned && engine.launchAgents.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 60)).foregroundStyle(Color(hex:"4ade80"))
                    Text("No threats found").font(.system(size: 20, weight: .semibold)).foregroundStyle(.white)
                    Text("Your Mac looks clean.").foregroundStyle(.white.opacity(0.6))
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else if !engine.launchAgents.isEmpty {
                List {
                    ForEach(engine.launchAgents) { agent in
                        HStack(spacing: 14) {
                            Image(systemName: agent.isSuspicious ? "exclamationmark.triangle.fill" : "checkmark.shield")
                                .font(.system(size: 22))
                                .foregroundStyle(agent.isSuspicious ? Color(hex:"f87171") : Color(hex:"4ade80"))
                            VStack(alignment: .leading, spacing: 3) {
                                Text(agent.name).font(.system(size: 14, weight: .semibold)).foregroundStyle(.white)
                                Text(agent.reason).font(.caption).foregroundStyle(.white.opacity(0.5))
                            }
                            Spacer()
                            if agent.isSuspicious {
                                Button("Remove") { engine.removeLaunchAgent(agent) }
                                    .buttonStyle(PillButtonStyle(color: Color(hex:"ef4444")))
                            }
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(Color.white.opacity(0.05))
                        .listRowSeparatorTint(.white.opacity(0.1))
                    }
                }
                .listStyle(.plain).scrollContentBackground(.hidden)
            } else {
                // Pre-scan hero
                Spacer()
                HStack { Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "shield").font(.system(size: 80, weight: .thin)).foregroundStyle(.white.opacity(0.3))
                        Text("Tap Scan to check for threats").foregroundStyle(.white.opacity(0.5))
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

// MARK: - Space Lens View

struct SpaceLensView: View {
    @ObservedObject var engine: CleanerEngine
    @State private var scanned = false
    @State private var expanded: Set<UUID> = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Space Lens").font(.system(size: 34, weight: .bold)).foregroundStyle(.white)
                    Text("See what's taking up space on your Mac.")
                        .font(.system(size: 14)).foregroundStyle(.white.opacity(0.65))
                }
                Spacer()
                Button(scanned ? "Rescan" : "Scan") {
                    Task { await engine.scanSpaceLens(); scanned = true }
                }
                .buttonStyle(PillButtonStyle(color: Color(hex:"8b5cf6")))
            }
            .padding(.horizontal, 28).padding(.top, 28).padding(.bottom, 20)

            if engine.isScanning {
                Spacer()
                VStack(spacing: 12) {
                    ProgressView().tint(.white).scaleEffect(1.5)
                    Text(engine.scanProgress).font(.system(size: 13)).foregroundStyle(.white.opacity(0.6))
                }
                .frame(maxWidth: .infinity)
                Spacer()
            } else if !engine.spaceNodes.isEmpty {
                List(engine.spaceNodes.prefix(50), id: \.id) { node in
                    SpaceNodeRow(node: node, total: engine.spaceNodes.first?.size ?? 1, expanded: $expanded) { toDelete in
                        engine.deleteSpaceNode(toDelete)
                    }
                        .listRowBackground(Color.white.opacity(0.05))
                        .listRowSeparatorTint(.white.opacity(0.1))
                }
                .listStyle(.plain).scrollContentBackground(.hidden)
            } else {
                Spacer()
                HStack { Spacer()
                    VStack(spacing: 16) {
                        Image(systemName: "magnifyingglass.circle").font(.system(size: 80, weight: .thin)).foregroundStyle(.white.opacity(0.3))
                        Text("Tap Scan to map your disk").foregroundStyle(.white.opacity(0.5))
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct SpaceNodeRow: View {
    let node: CleanerEngine.SpaceNode
    let total: Int64
    @Binding var expanded: Set<UUID>
    let onDelete: (CleanerEngine.SpaceNode) -> Void

    private var fraction: Double { total > 0 ? Double(node.size) / Double(total) : 0 }
    private var isExpanded: Bool { expanded.contains(node.id) }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: node.isDirectory ? "folder.fill" : "doc.fill")
                    .foregroundStyle(node.isDirectory ? Color(hex:"fbbf24") : Color(hex:"94a3b8"))
                    .frame(width: 20)
                VStack(alignment: .leading, spacing: 3) {
                    Text(node.name).foregroundStyle(.white).lineLimit(1)
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.white.opacity(0.1)).frame(height: 4)
                            Capsule().fill(Color(hex:"8b5cf6").opacity(0.8))
                                .frame(width: geo.size.width * fraction, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                Spacer()
                Text(node.size.formatted(.byteCount(style: .file)))
                    .font(.subheadline.monospacedDigit()).foregroundStyle(.white.opacity(0.7))
                Button {
                    onDelete(node)
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(hex:"f87171"))
                }
                .buttonStyle(.plain)
                if node.isDirectory && !node.children.isEmpty {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 11)).foregroundStyle(.white.opacity(0.4))
                }
            }
            .padding(.vertical, 6)
            .contentShape(Rectangle())
            .onTapGesture {
                if node.isDirectory && !node.children.isEmpty {
                    if isExpanded { expanded.remove(node.id) } else { expanded.insert(node.id) }
                }
            }

            if isExpanded {
                ForEach(node.children) { child in
                    HStack(spacing: 12) {
                        Spacer().frame(width: 28)
                        Image(systemName: child.isDirectory ? "folder.fill" : "doc.fill")
                            .foregroundStyle(child.isDirectory ? Color(hex:"fbbf24").opacity(0.7) : Color(hex:"94a3b8").opacity(0.7))
                            .frame(width: 16)
                        Text(child.name).font(.system(size: 13)).foregroundStyle(.white.opacity(0.8)).lineLimit(1)
                        Spacer()
                        Text(child.size.formatted(.byteCount(style: .file)))
                            .font(.caption.monospacedDigit()).foregroundStyle(.white.opacity(0.5))
                        Button { onDelete(child) } label: {
                            Image(systemName: "trash").font(.system(size: 11)).foregroundStyle(Color(hex:"f87171"))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 3)
                }
            }
        }
    }
}

#Preview { ContentView() }

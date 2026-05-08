import SwiftUI

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
        }
    }

    var isSeparatorBefore: Bool { self == .myTools }
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
            LinearGradient(colors: selected.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.4), value: selected)
            HStack(spacing: 0) {
                sidebarView
                mainArea
            }
        }
        .frame(minWidth: 900, minHeight: 580)
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
        .frame(width: 210)
        .background(Color.black.opacity(0.25))
    }

    // MARK: Main Area
    private var mainArea: some View {
        Group {
            switch selected {
            case .myTools:      MyToolsView(searchText: $searchText)
            case .myActivity:   MyActivityView()
            case .cloudCleanup: CloudCleanupView(accentColor: selected.accentColor)
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
        HStack(alignment: .center, spacing: 0) {
            ZStack {
                if engine.isScanning {
                    ProgressView().scaleEffect(2).tint(.white)
                } else {
                    HeroGem(icon: selected.heroIcon, accent: selected.accentColor)
                }
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(selected.rawValue)
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(selected.subtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: 280)
                }
                VStack(alignment: .leading, spacing: 14) {
                    ForEach(selected.features, id: \.label) { f in
                        FeatureRow(icon: f.icon, label: f.label, accent: selected.accentColor)
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
                    Circle().fill(selected.accentColor.opacity(0.35)).frame(width: 72, height: 72)
                    Circle().fill(selected.accentColor.opacity(0.6)).frame(width: 60, height: 60)
                    if engine.isScanning { ProgressView().tint(.white) }
                    else { Text(showResults ? "Rescan" : "Scan").font(.system(size: 15, weight: .semibold)).foregroundStyle(.white) }
                }
            }
            .buttonStyle(.plain)
            .disabled(engine.isScanning || engine.isClearing)
            .shadow(color: selected.accentColor.opacity(0.6), radius: 16, y: 4)
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

// MARK: - My Tools View

struct MyToolsView: View {
    @Binding var searchText: String
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
                        ToolCardView(card: card)
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
                Button("Scan") {}
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

    let services: [(icon: String, color: Color, name: String)] = [
        ("icloud.fill",    Color(hex:"3b82f6"), "Connect iCloud"),
        ("g.circle.fill",  Color(hex:"ea4335"), "Connect Google Drive"),
        ("cloud.fill",     Color(hex:"0078d4"), "Connect OneDrive"),
        ("drop.fill",      Color(hex:"0061ff"), "Connect Dropbox"),
    ]

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(spacing: 0) {
                HeroGem(icon: "icloud", accent: accentColor)
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
                        Button(action: {}) {
                            HStack(spacing: 14) {
                                Image(systemName: svc.icon)
                                    .font(.system(size: 18))
                                    .foregroundStyle(svc.color)
                                    .frame(width: 28)
                                Text(svc.name)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: 280)
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

private struct SidebarItem: View {
    let section: AppSection
    let isSelected: Bool

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
            isSelected ? RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.15)) : nil
        )
        .padding(.horizontal, 10)
        .contentShape(Rectangle())
    }
}

private struct HeroGem: View {
    let icon: String
    let accent: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 60, style: .continuous)
                .fill(accent.opacity(0.15))
                .frame(width: 300, height: 300)
                .blur(radius: 30)
            RoundedRectangle(cornerRadius: 52, style: .continuous)
                .fill(LinearGradient(colors: [accent.opacity(0.55), accent.opacity(0.2), Color.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 240, height: 240)
                .overlay(
                    RoundedRectangle(cornerRadius: 52, style: .continuous)
                        .stroke(LinearGradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
                )
                .shadow(color: accent.opacity(0.5), radius: 40, y: 20)
            Image(systemName: icon)
                .font(.system(size: 80, weight: .thin))
                .foregroundStyle(.white.opacity(0.9))
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

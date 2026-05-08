import Foundation
import Combine

@MainActor
class CleanerEngine: ObservableObject {
    @Published var scannedBytes: Int64 = 0
    @Published var freedBytes: Int64 = 0
    @Published var isScanning = false
    @Published var isClearing = false
    @Published var items: [CleanItem] = []
    @Published var scanProgress: String = ""

    struct CleanItem: Identifiable {
        let id = UUID()
        let url: URL
        let size: Int64
        let category: Category

        enum Category: String, CaseIterable {
            case userCache       = "User Cache"
            case systemCache     = "System Cache"
            case appSupportCache = "App Support Cache"
            case containerCache  = "Container Cache"
            case logs            = "Log Files"
            case temp            = "Temp Files"
            case xcode           = "Xcode Junk"
            case devTools        = "Dev Tool Cache"
            case trash           = "Trash"
            case largeFile       = "Large Files"
            case downloads       = "Downloads"
            case loginItems      = "Login Items"
            case appLeftovers    = "App Leftovers"
            case privacyTrace    = "Privacy Traces"
        }
    }

    // MARK: - Login Items

    struct LoginItem: Identifiable {
        let id = UUID()
        let name: String
        let path: String
        let bundleID: String?
        let plistURL: URL?
        var enabled: Bool
    }

    @Published var loginItems: [LoginItem] = []

    // MARK: - Launch Agents

    struct LaunchAgent: Identifiable {
        let id = UUID()
        let name: String
        let url: URL
        let isSuspicious: Bool
        let reason: String
    }

    @Published var launchAgents: [LaunchAgent] = []

    // MARK: - Space Lens

    struct SpaceNode: Identifiable {
        let id = UUID()
        let name: String
        let url: URL
        let size: Int64
        let isDirectory: Bool
        var children: [SpaceNode] = []
    }

    @Published var spaceNodes: [SpaceNode] = []

    // MARK: - Scan History

    struct ScanRecord: Codable, Identifiable {
        let id: UUID
        let date: Date
        let freedBytes: Int64
        let itemCount: Int
    }

    @Published var scanHistory: [ScanRecord] = []

    // MARK: - Public

    func scan() async {
        isScanning = true
        items = []
        scannedBytes = 0

        var found: [CleanItem] = []

        let tasks: [(String, () async -> [CleanItem])] = [
            ("User Caches",         scanUserCaches),
            ("System Caches",       scanSystemCaches),
            ("App Support Caches",  scanAppSupportCaches),
            ("Container Caches",    scanContainerCaches),
            ("Log Files",           scanLogs),
            ("Temp Files",          scanTemp),
            ("Xcode Junk",          scanXcode),
            ("Dev Tool Caches",     scanDevTools),
            ("Trash",               scanTrash),
            ("Large Files",         scanLargeFiles),
            ("Downloads",           scanDownloads),
            ("App Leftovers",       scanAppLeftovers),
            ("Privacy Traces",      scanPrivacyTraces),
        ]

        for (label, task) in tasks {
            scanProgress = label
            let result = await task()
            found += result
            scannedBytes = found.reduce(0) { $0 + $1.size }
        }

        // Sort by size descending
        items = found.sorted { $0.size > $1.size }
        scannedBytes = items.reduce(0) { $0 + $1.size }
        scanProgress = ""
        isScanning = false
    }

    func clearAll() async {
        isClearing = true
        var freed: Int64 = 0
        var remaining: [CleanItem] = []
        for item in items {
            do {
                try FileManager.default.removeItem(at: item.url)
                freed += item.size
            } catch {
                remaining.append(item)
            }
        }
        freedBytes += freed
        items = remaining.sorted { $0.size > $1.size }
        scannedBytes = remaining.reduce(0) { $0 + $1.size }
        isClearing = false
    }

    func clear(items toDelete: [CleanItem]) async {
        isClearing = true
        var freed: Int64 = 0
        let deleteIDs = Set(toDelete.map { $0.id })
        var remaining: [CleanItem] = []
        for item in items {
            if deleteIDs.contains(item.id) {
                do {
                    try FileManager.default.removeItem(at: item.url)
                    freed += item.size
                } catch {
                    remaining.append(item)
                }
            } else {
                remaining.append(item)
            }
        }
        freedBytes += freed
        items = remaining.sorted { $0.size > $1.size }
        scannedBytes = remaining.reduce(0) { $0 + $1.size }
        isClearing = false
        saveHistory()
    }

    // MARK: - Login Items

    func scanLoginItems() async {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var found: [LoginItem] = []
        let dirs = [
            home.appendingPathComponent("Library/LaunchAgents"),
            URL(fileURLWithPath: "/Library/LaunchAgents"),
            URL(fileURLWithPath: "/Library/LaunchDaemons"),
        ]
        for dir in dirs {
            guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else { continue }
            for file in files where file.pathExtension == "plist" {
                guard let dict = NSDictionary(contentsOf: file) else { continue }
                let label = dict["Label"] as? String ?? file.deletingPathExtension().lastPathComponent
                let prog = (dict["Program"] as? String) ?? ((dict["ProgramArguments"] as? [String])?.first ?? "")
                // Check if disabled via launchctl overrides
                let disabled = (dict["Disabled"] as? Bool) ?? false
                found.append(LoginItem(name: label, path: prog, bundleID: nil, plistURL: file, enabled: !disabled))
            }
        }
        loginItems = found.sorted { $0.name < $1.name }
    }

    func toggleLoginItem(_ item: LoginItem) {
        guard let idx = loginItems.firstIndex(where: { $0.id == item.id }),
              let plist = loginItems[idx].plistURL else { return }
        let enable = !loginItems[idx].enabled
        let task = Process()
        task.launchPath = "/bin/launchctl"
        task.arguments = [enable ? "load" : "unload", "-w", plist.path]
        try? task.run()
        task.waitUntilExit()
        loginItems[idx].enabled = enable
    }

    // MARK: - Launch Agent Protection Scan

    func scanLaunchAgents() async {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var found: [LaunchAgent] = []
        let dirs = [
            home.appendingPathComponent("Library/LaunchAgents"),
            URL(fileURLWithPath: "/Library/LaunchAgents"),
            URL(fileURLWithPath: "/Library/LaunchDaemons"),
        ]
        let suspiciousKeywords = ["adware", "spigot", "genieo", "vsearch", "conduit", "crossrider", "installmac", "mackeeper", "zeobit"]
        for dir in dirs {
            guard let files = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else { continue }
            for file in files where file.pathExtension == "plist" {
                guard let dict = NSDictionary(contentsOf: file) else { continue }
                let label = (dict["Label"] as? String ?? file.lastPathComponent).lowercased()
                let prog = ((dict["Program"] as? String) ?? (dict["ProgramArguments"] as? [String])?.first ?? "").lowercased()
                let combined = label + prog
                if let keyword = suspiciousKeywords.first(where: { combined.contains($0) }) {
                    found.append(LaunchAgent(name: dict["Label"] as? String ?? file.lastPathComponent, url: file, isSuspicious: true, reason: "Matches known adware pattern: \(keyword)"))
                } else {
                    // Flag items pointing to non-existent binaries
                    let progPath = (dict["Program"] as? String) ?? (dict["ProgramArguments"] as? [String])?.first ?? ""
                    if !progPath.isEmpty && !FileManager.default.fileExists(atPath: progPath) {
                        found.append(LaunchAgent(name: dict["Label"] as? String ?? file.lastPathComponent, url: file, isSuspicious: true, reason: "Points to missing binary"))
                    }
                }
            }
        }
        launchAgents = found
    }

    func deleteSpaceNode(_ node: SpaceNode) {
        do {
            try FileManager.default.removeItem(at: node.url)
            freedBytes += node.size
            spaceNodes.removeAll { $0.id == node.id }
            // Also remove from children of any parent
            for i in spaceNodes.indices {
                spaceNodes[i].children.removeAll { $0.id == node.id }
            }
        } catch {
            // File may be protected — silently skip
        }
    }

    func removeLaunchAgent(_ agent: LaunchAgent) {
        try? FileManager.default.removeItem(at: agent.url)
        launchAgents.removeAll { $0.id == agent.id }
    }

    // MARK: - Space Lens

    func scanSpaceLens(at path: String = NSHomeDirectory()) async {
        isScanning = true
        scanProgress = "Mapping disk..."
        let url = URL(fileURLWithPath: path)
        spaceNodes = await Task.detached(priority: .userInitiated) {
            self.buildNodes(url: url, depth: 0, maxDepth: 2)
        }.value
        isScanning = false
        scanProgress = ""
    }

    // MARK: - History

    func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: "scanHistory"),
              let records = try? JSONDecoder().decode([ScanRecord].self, from: data) else { return }
        scanHistory = records
    }

    private func saveHistory() {
        let record = ScanRecord(id: UUID(), date: Date(), freedBytes: freedBytes, itemCount: items.count)
        scanHistory.insert(record, at: 0)
        if scanHistory.count > 50 { scanHistory = Array(scanHistory.prefix(50)) }
        if let data = try? JSONEncoder().encode(scanHistory) {
            UserDefaults.standard.set(data, forKey: "scanHistory")
        }
    }

    // MARK: - Scanners

    private func scanUserCaches() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return collectDir(home.appendingPathComponent("Library/Caches"), category: .userCache)
    }

    private func scanSystemCaches() async -> [CleanItem] {
        var result: [CleanItem] = []
        result += collectDir(URL(fileURLWithPath: "/Library/Caches"), category: .systemCache)
        result += collectDir(URL(fileURLWithPath: "/private/var/folders"), category: .systemCache)
        return result
    }

    private func scanAppSupportCaches() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let appSupport = home.appendingPathComponent("Library/Application Support")
        var result: [CleanItem] = []
        let fm = FileManager.default
        guard let apps = try? fm.contentsOfDirectory(at: appSupport, includingPropertiesForKeys: nil) else { return [] }
        for app in apps {
            for sub in ["Cache", "Caches", "cache", "caches"] {
                result += collectDir(app.appendingPathComponent(sub), category: .appSupportCache)
            }
            result += collectDir(app.appendingPathComponent("Logs"), category: .logs)
        }
        return result
    }

    private func scanContainerCaches() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var result: [CleanItem] = []
        for base in ["Library/Containers", "Library/Group Containers"] {
            let dir = home.appendingPathComponent(base)
            guard let containers = try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil) else { continue }
            for c in containers {
                result += collectDir(c.appendingPathComponent("Data/Library/Caches"), category: .containerCache)
                result += collectDir(c.appendingPathComponent("Data/Library/Logs"), category: .logs)
                result += collectDir(c.appendingPathComponent("Data/tmp"), category: .temp)
            }
        }
        return result
    }

    private func scanLogs() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var result: [CleanItem] = []
        result += collectDir(home.appendingPathComponent("Library/Logs"), category: .logs)
        result += collectDir(URL(fileURLWithPath: "/Library/Logs"), category: .logs)
        result += collectDir(URL(fileURLWithPath: "/var/log"), category: .logs)
        return result
    }

    private func scanTemp() async -> [CleanItem] {
        var result: [CleanItem] = []
        result += collectDir(URL(fileURLWithPath: NSTemporaryDirectory()), category: .temp)
        result += collectDir(URL(fileURLWithPath: "/private/tmp"), category: .temp)
        return result
    }

    private func scanXcode() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let dev = home.appendingPathComponent("Library/Developer")
        var result: [CleanItem] = []
        // DerivedData — biggest offender
        result += collectDir(dev.appendingPathComponent("Xcode/DerivedData"), category: .xcode)
        // Old device support symbols
        result += collectDir(dev.appendingPathComponent("Xcode/iOS DeviceSupport"), category: .xcode)
        result += collectDir(dev.appendingPathComponent("Xcode/watchOS DeviceSupport"), category: .xcode)
        result += collectDir(dev.appendingPathComponent("Xcode/tvOS DeviceSupport"), category: .xcode)
        // Simulator caches
        result += collectDir(dev.appendingPathComponent("CoreSimulator/Caches"), category: .xcode)
        result += collectDir(dev.appendingPathComponent("Xcode/Archives"), category: .xcode)
        return result
    }

    private func scanDevTools() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var result: [CleanItem] = []
        let devCaches: [String] = [
            ".npm/_cacache",
            ".yarn/cache",
            ".gradle/caches",
            ".m2/repository",
            ".cocoapods/repos",
            ".pub-cache",
            ".cargo/registry",
            ".rustup/toolchains",
            "Library/Caches/pip",
            "Library/Caches/com.apple.python",
        ]
        for path in devCaches {
            result += collectDir(home.appendingPathComponent(path), category: .devTools)
        }
        return result
    }

    private func scanTrash() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var result: [CleanItem] = []
        result += collectDir(home.appendingPathComponent(".Trash"), category: .trash)
        // External volume trashes
        let fm = FileManager.default
        if let vols = try? fm.contentsOfDirectory(at: URL(fileURLWithPath: "/Volumes"), includingPropertiesForKeys: nil) {
            for vol in vols {
                result += collectDir(vol.appendingPathComponent(".Trashes"), category: .trash)
            }
        }
        return result
    }

    private func scanLargeFiles() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var result: [CleanItem] = []
        let threshold: Int64 = 50 * 1024 * 1024 // 50 MB
        for dir in ["Documents", "Desktop", "Movies", "Music"] {
            result += collectDir(home.appendingPathComponent(dir), category: .largeFile, minSize: threshold)
        }
        return result
    }

    private func scanDownloads() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return collectDir(home.appendingPathComponent("Downloads"), category: .downloads)
    }

    private func scanAppLeftovers() async -> [CleanItem] {
        let fm = FileManager.default
        let home = fm.homeDirectoryForCurrentUser
        // Find installed app bundle IDs
        var installedIDs = Set<String>()
        let appDirs = ["/Applications", home.appendingPathComponent("Applications").path]
        for dir in appDirs {
            guard let apps = try? fm.contentsOfDirectory(atPath: dir) else { continue }
            for app in apps where app.hasSuffix(".app") {
                let plist = "\(dir)/\(app)/Contents/Info.plist"
                if let dict = NSDictionary(contentsOfFile: plist),
                   let bid = dict["CFBundleIdentifier"] as? String {
                    installedIDs.insert(bid)
                    // Also store the app name prefix
                    installedIDs.insert(String(app.dropLast(4)))
                }
            }
        }

        var result: [CleanItem] = []
        let searchDirs = [
            home.appendingPathComponent("Library/Application Support"),
            home.appendingPathComponent("Library/Preferences"),
            home.appendingPathComponent("Library/Saved Application State"),
        ]
        for dir in searchDirs {
            guard let entries = try? fm.contentsOfDirectory(at: dir, includingPropertiesForKeys: [.fileSizeKey]) else { continue }
            for entry in entries {
                let name = entry.lastPathComponent
                // If no installed app matches this name, it's a leftover
                let isLeftover = !installedIDs.contains(where: { name.contains($0) || $0.contains(name) })
                if isLeftover {
                    let size = directorySize(entry)
                    if size > 0 {
                        result.append(CleanItem(url: entry, size: size, category: .appLeftovers))
                    }
                }
            }
        }
        return result
    }

    private func scanPrivacyTraces() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        var result: [CleanItem] = []
        // Recent items / LSSharedFileList
        result += collectDir(home.appendingPathComponent("Library/Application Support/com.apple.sharedfilelist"), category: .privacyTrace)
        // QuickLook thumbnails
        result += collectDir(home.appendingPathComponent("Library/Caches/com.apple.QuickLook.thumbnailcache"), category: .privacyTrace)
        // Safari history / cache
        result += collectDir(home.appendingPathComponent("Library/Safari/LocalStorage"), category: .privacyTrace)
        result += collectDir(home.appendingPathComponent("Library/Caches/com.apple.Safari"), category: .privacyTrace)
        // Chrome
        result += collectDir(home.appendingPathComponent("Library/Application Support/Google/Chrome/Default/Cache"), category: .privacyTrace)
        // Firefox
        result += collectDir(home.appendingPathComponent("Library/Caches/Firefox"), category: .privacyTrace)
        return result
    }

    // MARK: - Helpers

    private func collectDir(_ dir: URL, category: CleanItem.Category, minSize: Int64 = 0) -> [CleanItem] {
        let fm = FileManager.default
        guard fm.fileExists(atPath: dir.path) else { return [] }
        guard let enumerator = fm.enumerator(
            at: dir,
            includingPropertiesForKeys: [.fileSizeKey, .isRegularFileKey],
            options: [.skipsHiddenFiles]
        ) else { return [] }

        var result: [CleanItem] = []
        for case let url as URL in enumerator {
            guard let vals = try? url.resourceValues(forKeys: [.fileSizeKey, .isRegularFileKey]),
                  vals.isRegularFile == true,
                  let size = vals.fileSize,
                  Int64(size) >= minSize else { continue }
            result.append(CleanItem(url: url, size: Int64(size), category: category))
        }
        return result
    }

    nonisolated func directorySize(_ url: URL) -> Int64 {
        guard let enumerator = FileManager().enumerator(
            at: url,
            includingPropertiesForKeys: [.fileSizeKey, .isRegularFileKey]
        ) else { return 0 }
        var total: Int64 = 0
        for case let u as URL in enumerator {
            if let v = try? u.resourceValues(forKeys: [.fileSizeKey, .isRegularFileKey]),
               v.isRegularFile == true, let s = v.fileSize {
                total += Int64(s)
            }
        }
        return total
    }

    nonisolated func buildNodes(url: URL, depth: Int, maxDepth: Int) -> [SpaceNode] {
        let fm = FileManager()
        guard let entries = try? fm.contentsOfDirectory(
            at: url,
            includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey],
            options: .skipsHiddenFiles
        ) else { return [] }

        func localDirSize(_ u: URL) -> Int64 {
            guard let e = fm.enumerator(at: u, includingPropertiesForKeys: [.fileSizeKey, .isRegularFileKey]) else { return 0 }
            var total: Int64 = 0
            for case let f as URL in e {
                if let v = try? f.resourceValues(forKeys: [.fileSizeKey, .isRegularFileKey]),
                   v.isRegularFile == true, let s = v.fileSize { total += Int64(s) }
            }
            return total
        }
        var nodes: [SpaceNode] = []
        for entry in entries {
            guard let vals = try? entry.resourceValues(forKeys: [.fileSizeKey, .isDirectoryKey]) else { continue }
            let isDir = vals.isDirectory ?? false
            if isDir {
                let size = localDirSize(entry)
                guard size > 0 else { continue }
                var node = SpaceNode(name: entry.lastPathComponent, url: entry, size: size, isDirectory: true)
                if depth < maxDepth {
                    node.children = Array(
                        buildNodes(url: entry, depth: depth + 1, maxDepth: maxDepth)
                            .sorted { $0.size > $1.size }
                            .prefix(8)
                    )
                }
                nodes.append(node)
            } else {
                let size = Int64(vals.fileSize ?? 0)
                if size > 0 {
                    nodes.append(SpaceNode(name: entry.lastPathComponent, url: entry, size: size, isDirectory: false))
                }
            }
        }
        return nodes.sorted { $0.size > $1.size }
    }
}

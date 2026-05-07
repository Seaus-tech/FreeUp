import Foundation
import Combine

@MainActor
class CleanerEngine: ObservableObject {
    @Published var scannedBytes: Int64 = 0
    @Published var freedBytes: Int64 = 0
    @Published var isScanning = false
    @Published var isClearing = false
    @Published var items: [CleanItem] = []
    @Published var needsPermission = false

    struct CleanItem: Identifiable {
        let id = UUID()
        let url: URL
        let size: Int64
        let category: Category

        enum Category: String, CaseIterable {
            case cache = "Caches"
            case temp = "Temp Files"
            case largeFile = "Large Files"
            case trash = "Trash"
            case downloads = "Downloads"
        }
    }

    func scan() async {
        isScanning = true
        needsPermission = false
        items = []
        scannedBytes = 0

        var found: [CleanItem] = []

        await withTaskGroup(of: [CleanItem].self) { group in
            group.addTask { await self.scanCaches() }
            group.addTask { await self.scanTemp() }
            group.addTask { await self.scanLargeFiles() }
            group.addTask { await self.scanTrash() }
            group.addTask { await self.scanDownloads() }
            for await result in group { found += result }
        }

        items = found
        scannedBytes = found.reduce(0) { $0 + $1.size }
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
        items = remaining
        scannedBytes = remaining.reduce(0) { $0 + $1.size }
        isClearing = false
    }

    // MARK: - Scanners

    private func scanCaches() async -> [CleanItem] {
        // Target ~/Library/Caches directly — allDomainsMask returns system /Library/Caches which is sandboxed
        let home = FileManager.default.homeDirectoryForCurrentUser
        let userCaches = home.appendingPathComponent("Library/Caches")
        return collectItems(in: userCaches, category: .cache)
    }

    private func scanTemp() async -> [CleanItem] {
        collectItems(in: URL(fileURLWithPath: NSTemporaryDirectory()), category: .temp)
    }

    private func scanLargeFiles() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return collectItems(in: home.appendingPathComponent("Documents"), category: .largeFile, minSize: 50 * 1024 * 1024)
    }

    private func scanTrash() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return collectItems(in: home.appendingPathComponent(".Trash"), category: .trash)
    }

    private func scanDownloads() async -> [CleanItem] {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return collectItems(in: home.appendingPathComponent("Downloads"), category: .downloads)
    }

    // MARK: - Helpers

    private func collectItems(in dir: URL, category: CleanItem.Category, minSize: Int64 = 0) -> [CleanItem] {
        guard let enumerator = FileManager.default.enumerator(
            at: dir,
            includingPropertiesForKeys: [.fileSizeKey, .isRegularFileKey],
            options: [.skipsHiddenFiles, .skipsPackageDescendants]
        ) else { return [] }

        var result: [CleanItem] = []
        for case let url as URL in enumerator {
            guard let values = try? url.resourceValues(forKeys: [.fileSizeKey, .isRegularFileKey]),
                  values.isRegularFile == true,
                  let size = values.fileSize,
                  Int64(size) >= minSize else { continue }
            result.append(CleanItem(url: url, size: Int64(size), category: category))
        }
        return result
    }
}

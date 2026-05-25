import Foundation

// Helper to organize scanned CleanItem results into logical app sections.
// This keeps UI routing and presentation consistent by deciding which
// items belong to Cleanup, My Clutter, Protection, Performance, or Cloud Cleanup.

@MainActor
struct OrganizedClean {
    enum Section: String {
        case cleanup
        case myClutter
        case protection
        case performance
        case cloudCleanup
        case other
    }

    static func organize(_ items: [CleanerEngine.CleanItem]) -> [Section: [CleanerEngine.CleanItem]] {
        var map: [Section: [CleanerEngine.CleanItem]] = [:]
        // initialize arrays
        for s in [Section.cleanup, .myClutter, .protection, .performance, .cloudCleanup, .other] { map[s] = [] }

        for item in items {
            switch item.category {
            case .largeFile:
                map[.myClutter]?.append(item)
            case .downloads:
                map[.myClutter]?.append(item)
            case .trash:
                map[.cleanup]?.append(item)
            case .userCache, .systemCache, .appSupportCache, .containerCache, .logs, .temp, .xcode, .devTools, .appLeftovers, .privacyTrace:
                map[.cleanup]?.append(item)
            case .loginItems:
                map[.performance]?.append(item)
            @unknown default:
                let lower = item.url.path.lowercased()
                if lower.contains("google drive") || lower.contains("dropbox") || lower.contains("icloud") || lower.contains("cloud") {
                    map[.cloudCleanup]?.append(item)
                } else {
                    map[.other]?.append(item)
                }
            }
        }

        return map
    }
}

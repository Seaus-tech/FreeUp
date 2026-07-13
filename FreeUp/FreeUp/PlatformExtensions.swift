import SwiftUI

// MARK: - Shared View Modifiers

extension View {
    /// Applies platform-appropriate card styling
    func cleanerCard() -> some View {
        modifier(CleanerCardModifier())
    }
}

private struct CleanerCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            #if os(macOS)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(0.06)))
            #elseif os(watchOS)
            .padding(6)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
            #else
            .padding(12)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
            #endif
    }
}

// MARK: - macOS

#if os(macOS)
extension View {
    func platformToolbar(onScan: @escaping () -> Void, onClear: @escaping () -> Void, canClear: Bool) -> some View {
        toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Scan", systemImage: "magnifyingglass", action: onScan)
            }
            ToolbarItem(placement: .destructiveAction) {
                Button("Clear All", systemImage: "trash", action: onClear)
                    .disabled(!canClear)
            }
        }
    }
}
#endif

// MARK: - iOS / iPadOS / visionOS

#if os(iOS) || os(visionOS)
extension View {
    func platformToolbar(onScan: @escaping () -> Void, onClear: @escaping () -> Void, canClear: Bool) -> some View {
        toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Scan", systemImage: "magnifyingglass", action: onScan)
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Clear All", systemImage: "trash", action: onClear)
                    .disabled(!canClear)
                    .tint(.red)
            }
        }
    }
}
#endif

// MARK: - tvOS

#if os(tvOS)
extension View {
    func platformToolbar(onScan: @escaping () -> Void, onClear: @escaping () -> Void, canClear: Bool) -> some View {
        // tvOS uses focusable buttons inline — no toolbar API
        self
    }
}
#endif

// MARK: - watchOS

#if os(watchOS)
extension View {
    func platformToolbar(onScan: @escaping () -> Void, onClear: @escaping () -> Void, canClear: Bool) -> some View {
        toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Scan", action: onScan)
            }
        }
    }
}
#endif

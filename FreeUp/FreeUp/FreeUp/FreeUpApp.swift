import SwiftUI

@main
struct FreeUpApp: App {
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .onAppear {
                    // Hide toolbar so gradient fills the full window
                    NSApplication.shared.windows.forEach { w in
                        w.titlebarAppearsTransparent = true
                        w.titleVisibility = .hidden
                        w.styleMask.insert(.fullSizeContentView)
                        w.isMovableByWindowBackground = true
                    }
                }
        }
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
        #elseif os(watchOS)
        WindowGroup {
            ContentView()
        }
        #else
        WindowGroup {
            ContentView()
        }
        #endif
    }
}

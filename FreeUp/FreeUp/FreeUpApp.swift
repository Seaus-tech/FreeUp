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
                        let defaultSize = NSSize(width: 1240, height: 800)
                        w.titlebarAppearsTransparent = true
                        w.titleVisibility = .hidden
                        w.styleMask.insert(.fullSizeContentView)
                        w.isMovableByWindowBackground = true
                        w.contentMinSize = NSSize(width: 1180, height: 760)
                        if w.frame.width < defaultSize.width || w.frame.height < defaultSize.height {
                            w.setContentSize(defaultSize)
                            w.center()
                        }
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

import SwiftUI
import SwiftData

@main
struct CapabilityFlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Local-first persistence for user notes.
        .modelContainer(for: Note.self)
    }
}

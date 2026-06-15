import SwiftUI

struct ContentView: View {
    @StateObject private var router = Router()

    var body: some View {
        TabView(selection: $router.selectedTab) {
            NavigationStack {
                ProcessListView()
                    .homeToolbar(router: router)
                    .commonDestinations()
            }
            .tabItem { Label("Process", systemImage: "list.bullet.indent") }
            .tag(AppTab.process)

            NavigationStack {
                OrganizationsView()
                    .homeToolbar(router: router)
                    .commonDestinations()
            }
            .tabItem { Label("Organizations", systemImage: "building.2") }
            .tag(AppTab.organizations)

            NavigationStack {
                MatrixView()
                    .homeToolbar(router: router)
                    .commonDestinations()
            }
            .tabItem { Label("Matrix", systemImage: "tablecells") }
            .tag(AppTab.matrix)

            NavigationStack {
                BuildPathView()
                    .homeToolbar(router: router)
                    .commonDestinations()
            }
            .tabItem { Label("Build", systemImage: "wand.and.stars") }
            .tag(AppTab.build)

            NavigationStack {
                GlossaryView()
                    .homeToolbar(router: router)
                    .commonDestinations()
            }
            .tabItem { Label("Glossary", systemImage: "character.book.closed") }
            .tag(AppTab.glossary)
        }
        .tint(Theme.accent)
        .environmentObject(router)
        // Home landing presented over the persistent tab bar.
        .fullScreenCover(isPresented: $router.showHome) {
            HomeView()
                .environmentObject(router)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: true)
}

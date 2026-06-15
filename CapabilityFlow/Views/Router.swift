import SwiftUI

/// App-wide tabs shown in the persistent bottom navigation bar.
enum AppTab: Hashable {
    case process, organizations, matrix, build, glossary
}

/// Shared navigation state. Lets the Home screen switch tabs and lets any
/// screen present the Home landing again.
@MainActor
final class Router: ObservableObject {
    @Published var selectedTab: AppTab = .process
    @Published var showHome: Bool = true   // Home landing shows on launch.

    func go(to tab: AppTab) {
        selectedTab = tab
        showHome = false
    }
}

/// Adds the standard set of deep-link destinations to a NavigationStack so
/// process steps, organizations, and glossary terms can be pushed from anywhere.
struct CommonDestinations: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ProcessStep.self) { ProcessDetailView(step: $0) }
            .navigationDestination(for: Organization.self) { OrganizationDetailView(org: $0) }
            .navigationDestination(for: GlossaryTerm.self) { GlossaryDetailView(term: $0) }
    }
}

extension View {
    func commonDestinations() -> some View { modifier(CommonDestinations()) }

    /// Standard toolbar button that re-presents the Home landing screen.
    func homeToolbar(router: Router) -> some View {
        toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    router.showHome = true
                } label: {
                    Image(systemName: "house")
                }
                .accessibilityLabel("Home")
            }
        }
    }
}

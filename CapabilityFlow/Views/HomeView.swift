import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var router: Router
    @State private var showOnboarding = false

    private let data = AppData.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header

                    keyIdeaCard

                    // Three large primary cards.
                    VStack(spacing: 14) {
                        BigCard(
                            title: "Explore the Process",
                            subtitle: "The 13-step operational problem → portfolio → evidence loop",
                            systemImage: "list.bullet.indent",
                            color: Theme.categoryColor(.concepts)
                        ) { router.go(to: .process) }

                        BigCard(
                            title: "Who Does What",
                            subtitle: "Responsibility matrix across the enterprise",
                            systemImage: "tablecells",
                            color: Theme.categoryColor(.requirements)
                        ) { router.go(to: .matrix) }

                        BigCard(
                            title: "Build a Capability Path",
                            subtitle: "Answer a few questions, get a recommended path",
                            systemImage: "wand.and.stars",
                            color: Theme.categoryColor(.acquisition)
                        ) { router.go(to: .build) }
                    }

                    // Secondary quick links.
                    quickLinks

                    caveatBanner
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { router.showHome = false }
                }
            }
            .sheet(isPresented: $showOnboarding) { OnboardingView() }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Capability Flow")
                .font(.largeTitle.bold())
            Text("Understand the Army capability-development ecosystem")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var keyIdeaCard: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 8) {
                Label("Key Idea", systemImage: "lightbulb")
                    .font(.headline)
                    .foregroundStyle(Theme.accent)
                Text(data.keyIdea)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
        }
    }

    private var quickLinks: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("More")
                .font(.headline)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                SmallCard(title: "Organizations", systemImage: "building.2") { router.go(to: .organizations) }
                SmallCard(title: "Glossary", systemImage: "character.book.closed") { router.go(to: .glossary) }
                NavigationLink {
                    QuizView()
                } label: {
                    SmallCardLabel(title: "Training Quiz", systemImage: "checkmark.seal")
                }
                NavigationLink {
                    NotesView()
                } label: {
                    SmallCardLabel(title: "Saved Notes", systemImage: "note.text")
                }
                Button { showOnboarding = true } label: {
                    SmallCardLabel(title: "New here? Start", systemImage: "graduationcap")
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var caveatBanner: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
                .foregroundStyle(.orange)
            Text(data.policyCaveat)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orange.opacity(0.10), in: RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Card components

private struct BigCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 52, height: 52)
                    .background(color, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                VStack(alignment: .leading, spacing: 4) {
                    Text(title).font(.headline).foregroundStyle(.primary)
                    Text(subtitle).font(.caption).foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
            }
            .padding(16)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct SmallCard: View {
    let title: String
    let systemImage: String
    let action: () -> Void
    var body: some View {
        Button(action: action) { SmallCardLabel(title: title, systemImage: systemImage) }
            .buttonStyle(.plain)
    }
}

struct SmallCardLabel: View {
    let title: String
    let systemImage: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundStyle(Theme.accent)
            Text(title)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    HomeView().environmentObject(Router())
}

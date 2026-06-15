import SwiftUI

/// Lightweight onboarding for new FCC / C2 FCD personnel and role-based primers.
struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var page = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "arrow.triangle.2.circlepath",
            title: "It's a loop, not a pipeline",
            body: "Capability development is best understood as an operational problem → portfolio → evidence loop. Work iterates; the field feeds the next cycle."
        ),
        OnboardingPage(
            icon: "person.3",
            title: "It's a distributed enterprise",
            body: "FCC and the FCDs do not replace CAC, DEVCOM, HQDA G-8, ASA(ALT), PEOs/PMs, or ATEC. Each owns a part. Shared operational problems connect them."
        ),
        OnboardingPage(
            icon: "questionmark.circle",
            title: "Ask the right questions",
            body: "Is this materiel or DOTMLPF-P? Who owns the problem? What does the evidence show? Can we afford it? Each process step lists questions to ask."
        )
    ]

    private let roles: [(String, String)] = [
        ("New FCD action officer", "Start with Process Steps 1–3 and the C2 FCD / FCD organization pages."),
        ("Requirements writer", "Focus on Steps 7–8, the FCC FID page, and the CBA/ICD/CDD glossary terms."),
        ("Experimentation planner", "See Step 6, JMC, and the Build a Path wizard."),
        ("Acquisition partner", "Review Steps 9–11 and the PAE / CPE / PEO / PM pages."),
        ("Senior leader", "Skim the Process map and the Who Does What matrix for the big picture.")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    TabView(selection: $page) {
                        ForEach(Array(pages.enumerated()), id: \.offset) { i, p in
                            VStack(spacing: 16) {
                                Image(systemName: p.icon)
                                    .font(.system(size: 54))
                                    .foregroundStyle(Theme.accent)
                                Text(p.title).font(.title2.bold()).multilineTextAlignment(.center)
                                Text(p.body)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 24)
                            .tag(i)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 280)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Role-based learning paths").font(.headline)
                        ForEach(roles, id: \.0) { role in
                            CardContainer {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(role.0).font(.subheadline.weight(.semibold))
                                    Text(role.1).font(.caption).foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { Button("Done") { dismiss() } }
            }
        }
    }
}

private struct OnboardingPage {
    let icon: String
    let title: String
    let body: String
}

#Preview { OnboardingView() }

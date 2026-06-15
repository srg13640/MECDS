import SwiftUI

struct BuildPathView: View {
    @State private var answers = CapabilityAnswers()
    @State private var recBox: RecBox?

    var body: some View {
        Form {
            Section {
                Text("Answer a few questions about a hypothetical capability. The app will suggest who to involve, first actions, likely artifacts, risks, and a battle rhythm. This is an educational aid, not authoritative guidance.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Section("The problem") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("What operational problem are you trying to solve?")
                        .font(.subheadline.weight(.medium))
                    TextField("Describe the problem (optional)", text: $answers.problemStatement, axis: .vertical)
                        .lineLimit(2...4)
                        .textFieldStyle(.roundedBorder)
                }
                Picker("Warfighting function most affected", selection: $answers.warfightingFunction) {
                    ForEach(warfightingFunctions, id: \.self) { Text($0).tag($0) }
                }
            }

            Section("Solution shape") {
                Picker("Likely solution", selection: $answers.solutionType) {
                    ForEach(SolutionType.allCases) { Text($0.rawValue).tag($0) }
                }
                triPicker("Requires Joint interoperability?", $answers.jointInteroperability)
                triPicker("Is the technology mature?", $answers.technologyMature)
                triPicker("Existing program / prototype / commercial option?", $answers.existingSolution)
            }

            Section("Path drivers") {
                triPicker("Needs experimentation?", $answers.experimentationNeeded)
                triPicker("Needs new doctrine, org, training, personnel, facilities, or policy?", $answers.dotmlpfpImplications)
                triPicker("Requires new funding?", $answers.fundingNeeded)
                Picker("Timeline", selection: $answers.urgency) {
                    ForEach(Urgency.allCases) { Text($0.rawValue).tag($0) }
                }
            }

            Section {
                Button {
                    recBox = RecBox(rec: RecommendationEngine.recommend(from: answers))
                } label: {
                    Label("Generate recommended path", systemImage: "wand.and.stars")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle("Build a Path")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $recBox) { box in
            RecommendationView(answers: answers, rec: box.rec)
        }
    }

    private func triPicker(_ label: String, _ binding: Binding<TriState>) -> some View {
        Picker(label, selection: binding) {
            ForEach(TriState.allCases) { Text($0.rawValue).tag($0) }
        }
        .pickerStyle(.menu)
    }
}

/// Wrapper to present a non-Identifiable recommendation via `.sheet(item:)`.
private struct RecBox: Identifiable {
    let id = UUID()
    let rec: CapabilityRecommendation
}

// MARK: - Recommendation result

struct RecommendationView: View {
    let answers: CapabilityAnswers
    let rec: CapabilityRecommendation
    @Environment(\.dismiss) private var dismiss
    @State private var showAddNote = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    CardContainer {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Recommended approach", systemImage: "map").font(.headline)
                            Text(rec.narrative)
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    CardContainer { BulletSection(title: "Organizations to involve", items: rec.organizations, systemImage: "building.2") }
                    CardContainer { numberedSection(title: "First five staff actions", items: rec.firstActions, systemImage: "list.number") }
                    CardContainer { BulletSection(title: "Likely artifacts", items: rec.likelyArtifacts, systemImage: "doc.text") }
                    CardContainer { BulletSection(title: "Key risks", items: rec.keyRisks, systemImage: "exclamationmark.triangle") }
                    CardContainer { BulletSection(title: "Recommended battle rhythm", items: rec.battleRhythm, systemImage: "calendar") }

                    Text("Reminder: capability development is a loop. Plan the feedback path from the start. Verify current authorities and guidance.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Recommended Path")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Close") { dismiss() } }
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showAddNote = true } label: { Image(systemName: "note.text.badge.plus") }
                        .accessibilityLabel("Save as note")
                }
            }
            .sheet(isPresented: $showAddNote) {
                NoteEditorView(
                    anchorKind: .scenario,
                    anchorRefId: nil,
                    anchorLabel: scenarioLabel,
                    prefilledBody: noteBody
                )
            }
        }
    }

    private func numberedSection(title: String, items: [String], systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: systemImage).font(.headline)
            ForEach(Array(items.enumerated()), id: \.offset) { idx, item in
                HStack(alignment: .top, spacing: 8) {
                    Text("\(idx + 1).").font(.subheadline.bold()).foregroundStyle(Theme.accent)
                    Text(item).font(.subheadline)
                }
            }
        }
    }

    private var scenarioLabel: String {
        let p = answers.problemStatement.isEmpty ? answers.warfightingFunction : answers.problemStatement
        return "Path: \(p.prefix(60))"
    }

    private var noteBody: String {
        var s = rec.narrative + "\n\nOrganizations: " + rec.organizations.joined(separator: ", ")
        s += "\n\nFirst actions:\n" + rec.firstActions.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n")
        return s
    }
}

#Preview {
    NavigationStack { BuildPathView() }
}

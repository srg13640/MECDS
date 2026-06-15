import SwiftUI

// MARK: - Process list (vertical timeline)

struct ProcessListView: View {
    private let data = AppData.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                CardContainer {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("The Capability-Development Loop")
                            .font(.headline)
                        Text(data.keyIdea)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Tap any step. The process is iterative — the last step feeds back into the first.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.bottom, 12)

                ForEach(Array(data.processSteps.enumerated()), id: \.element.id) { index, step in
                    NavigationLink(value: step) {
                        TimelineRow(step: step, isLast: index == data.processSteps.count - 1)
                    }
                    .buttonStyle(.plain)
                }

                // Loop indicator.
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundStyle(Theme.accent)
                    Text("Feedback returns to Steps 1–3 — the loop continues.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .padding(.leading, 4)
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Process")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct TimelineRow: View {
    let step: ProcessStep
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            // Number + connecting line.
            VStack(spacing: 0) {
                Text("\(step.number)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(Theme.accent, in: Circle())
                if !isLast {
                    Rectangle()
                        .fill(Theme.accent.opacity(0.3))
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                }
            }
            .frame(minHeight: 70)

            VStack(alignment: .leading, spacing: 4) {
                Text(step.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(step.shortDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom, 16)
            Spacer(minLength: 0)
            Image(systemName: "chevron.right").foregroundStyle(.tertiary)
        }
    }
}

// MARK: - Process detail

struct ProcessDetailView: View {
    let step: ProcessStep
    private let data = AppData.shared
    @State private var showAddNote = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 8) {
                    Badge(text: "Step \(step.number) of 13", color: Theme.accent)
                    Text(step.title).font(.title2.bold())
                    Text(step.detailedDescription)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Primary organizations (deep-linkable when resolvable).
                CardContainer {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Primary organizations", systemImage: "building.2").font(.headline)
                        FlowChips(items: step.organizations) { label in
                            data.resolveOrganization(label: label)
                        }
                    }
                }

                CardContainer { BulletSection(title: "Key outputs / artifacts", items: step.outputs, systemImage: "doc.text") }
                CardContainer { BulletSection(title: "Common friction points", items: step.frictionPoints, systemImage: "exclamationmark.triangle") }
                CardContainer { BulletSection(title: "Questions a staff officer should ask", items: step.keyQuestions, systemImage: "questionmark.circle") }

                // Next steps (non-linear).
                if !step.nextSteps.isEmpty {
                    CardContainer {
                        VStack(alignment: .leading, spacing: 10) {
                            Label("Typically flows to", systemImage: "arrow.turn.down.right").font(.headline)
                            ForEach(step.nextSteps, id: \.self) { sid in
                                if let next = data.step(id: sid) {
                                    NavigationLink(value: next) {
                                        HStack {
                                            Text("\(next.number). \(next.title)")
                                                .font(.subheadline)
                                                .foregroundStyle(Theme.accent)
                                            Spacer()
                                            Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary)
                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Step \(step.number)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showAddNote = true } label: { Image(systemName: "note.text.badge.plus") }
                    .accessibilityLabel("Add note")
            }
        }
        .sheet(isPresented: $showAddNote) {
            NoteEditorView(anchorKind: .processStep, anchorRefId: step.id, anchorLabel: "Step \(step.number): \(step.title)")
        }
    }
}

// MARK: - Chips that deep-link when an organization can be resolved

struct FlowChips: View {
    let items: [String]
    let resolve: (String) -> Organization?

    var body: some View {
        FlexibleWrap(items: items, spacing: 8) { label in
            if let org = resolve(label) {
                NavigationLink(value: org) {
                    chip(label, linked: true)
                }
                .buttonStyle(.plain)
            } else {
                chip(label, linked: false)
            }
        }
    }

    private func chip(_ text: String, linked: Bool) -> some View {
        HStack(spacing: 4) {
            Text(text).font(.caption.weight(.medium))
            if linked { Image(systemName: "arrow.up.right").font(.system(size: 8)) }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            (linked ? Theme.accent.opacity(0.15) : Color(.tertiarySystemFill)),
            in: Capsule()
        )
        .foregroundStyle(linked ? Theme.accent : .secondary)
    }
}

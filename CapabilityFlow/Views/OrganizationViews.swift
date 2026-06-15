import SwiftUI

struct OrganizationsView: View {
    private let data = AppData.shared
    @State private var search = ""
    @State private var selectedCategory: OrgCategory? = nil

    private var filtered: [Organization] {
        data.organizations.filter { org in
            (selectedCategory == nil || org.category == selectedCategory)
            && (search.isEmpty || org.searchText.contains(search.lowercased()))
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // Category filter chips.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "All", isSelected: selectedCategory == nil) {
                            selectedCategory = nil
                        }
                        ForEach(OrgCategory.allCases) { cat in
                            FilterChip(title: cat.rawValue, isSelected: selectedCategory == cat, color: Theme.categoryColor(cat)) {
                                selectedCategory = (selectedCategory == cat) ? nil : cat
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }

                LazyVStack(spacing: 10) {
                    ForEach(filtered) { org in
                        NavigationLink(value: org) {
                            OrgRow(org: org)
                        }
                        .buttonStyle(.plain)
                    }
                    if filtered.isEmpty {
                        ContentUnavailableView("No organizations", systemImage: "magnifyingglass", description: Text("Try a different search or filter."))
                            .padding(.top, 40)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .padding(.top, 8)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Organizations")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search organizations")
    }
}

private struct OrgRow: View {
    let org: Organization
    var body: some View {
        CardContainer {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(org.abbreviation).font(.headline)
                        Badge(text: org.category.rawValue, color: Theme.categoryColor(org.category))
                    }
                    Text(org.name).font(.caption).foregroundStyle(.secondary)
                    Text(org.plainEnglishRole)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer(minLength: 0)
                Image(systemName: "chevron.right").foregroundStyle(.tertiary)
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    var color: Color = Theme.accent
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(isSelected ? color : Color(.tertiarySystemFill), in: Capsule())
                .foregroundStyle(isSelected ? .white : .primary)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Organization detail

struct OrganizationDetailView: View {
    let org: Organization
    private let data = AppData.shared
    @State private var showAddNote = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(org.abbreviation).font(.title.bold())
                        Badge(text: org.category.rawValue, color: Theme.categoryColor(org.category))
                    }
                    Text(org.name).font(.headline).foregroundStyle(.secondary)
                    Text(org.plainEnglishRole)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }

                CardContainer { BulletSection(title: "What they own", items: org.owns, systemImage: "checkmark.seal") }
                CardContainer { BulletSection(title: "What they do not own", items: org.doesNotOwn, systemImage: "xmark.seal") }

                CardContainer {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("When to involve them", systemImage: "clock").font(.headline)
                        Text(org.whenToInvolve).font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                CardContainer { BulletSection(title: "Key relationships", items: org.keyRelationships, systemImage: "link") }
                CardContainer { BulletSection(title: "Typical outputs", items: org.typicalOutputs, systemImage: "doc.text") }

                // Related process steps (deep links).
                if !org.relatedProcessSteps.isEmpty {
                    CardContainer {
                        VStack(alignment: .leading, spacing: 10) {
                            Label("Related process steps", systemImage: "list.bullet.indent").font(.headline)
                            ForEach(org.relatedProcessSteps, id: \.self) { sid in
                                if let step = data.step(id: sid) {
                                    NavigationLink(value: step) {
                                        HStack {
                                            Text("\(step.number). \(step.title)")
                                                .font(.subheadline).foregroundStyle(Theme.accent)
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
        .navigationTitle(org.abbreviation)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showAddNote = true } label: { Image(systemName: "note.text.badge.plus") }
                    .accessibilityLabel("Add note")
            }
        }
        .sheet(isPresented: $showAddNote) {
            NoteEditorView(anchorKind: .organization, anchorRefId: org.id, anchorLabel: "\(org.abbreviation) — \(org.name)")
        }
    }
}

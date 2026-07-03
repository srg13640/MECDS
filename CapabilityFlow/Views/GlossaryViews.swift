import SwiftUI

struct GlossaryView: View {
    private let data = AppData.shared
    @State private var search = ""

    private var filtered: [GlossaryTerm] {
        let base = search.isEmpty
            ? data.glossary
            : data.glossary.filter { $0.searchText.contains(search.lowercased()) }
        return base.sorted { $0.term.localizedCaseInsensitiveCompare($1.term) == .orderedAscending }
    }

    var body: some View {
        List {
            ForEach(filtered) { term in
                NavigationLink(value: term) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(term.term).font(.headline)
                        Text(term.definition)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 2)
                }
            }
            if filtered.isEmpty {
                ContentUnavailableView.search(text: search)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Glossary")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search terms")
    }
}

struct GlossaryDetailView: View {
    let term: GlossaryTerm
    @State private var showAddNote = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(term.term).font(.largeTitle.bold())

                CardContainer {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Plain-English definition", systemImage: "text.alignleft").font(.headline)
                        Text(term.definition).font(.body).fixedSize(horizontal: false, vertical: true)
                    }
                }
                CardContainer {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Why it matters", systemImage: "star").font(.headline)
                        Text(term.whyItMatters).font(.subheadline).fixedSize(horizontal: false, vertical: true)
                    }
                }
                CardContainer {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Example", systemImage: "quote.opening").font(.headline)
                        Text("“\(term.example)”").font(.subheadline).italic().foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                if let basis = term.statutoryBasis {
                    CardContainer {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Statutory basis", systemImage: "building.columns").font(.headline)
                            Text(basis).font(.subheadline).fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(term.term)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showAddNote = true } label: { Image(systemName: "note.text.badge.plus") }
                    .accessibilityLabel("Add note")
            }
        }
        .sheet(isPresented: $showAddNote) {
            NoteEditorView(anchorKind: .glossaryTerm, anchorRefId: term.id, anchorLabel: "Glossary: \(term.term)")
        }
    }
}

#Preview {
    NavigationStack { GlossaryView().commonDestinations() }
}

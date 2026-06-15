import SwiftUI
import SwiftData

// MARK: - Notes list

struct NotesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Note.createdAt, order: .reverse) private var notes: [Note]
    @State private var showNew = false

    var body: some View {
        Group {
            if notes.isEmpty {
                ContentUnavailableView {
                    Label("No notes yet", systemImage: "note.text")
                } description: {
                    Text("Save notes from any process step, organization, glossary term, or capability path. They stay on this device.")
                } actions: {
                    Button { showNew = true } label: { Label("New note", systemImage: "plus") }
                        .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    ForEach(notes) { note in
                        NavigationLink {
                            NoteEditorView(existing: note)
                        } label: {
                            NoteRow(note: note)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Saved Notes")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showNew = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showNew) {
            NoteEditorView(anchorKind: .general)
        }
    }

    private func delete(at offsets: IndexSet) {
        for i in offsets { context.delete(notes[i]) }
    }
}

private struct NoteRow: View {
    let note: Note
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(note.title.isEmpty ? "Untitled note" : note.title)
                    .font(.headline)
                Spacer()
                Badge(text: note.anchorKind.rawValue, color: Theme.accent)
            }
            if let label = note.anchorLabel, !label.isEmpty {
                Text(label).font(.caption).foregroundStyle(Theme.accent).lineLimit(1)
            }
            if !note.body.isEmpty {
                Text(note.body).font(.caption).foregroundStyle(.secondary).lineLimit(2)
            }
            Text(note.createdAt, style: .date).font(.caption2).foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Note editor (create or edit)

struct NoteEditorView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    // Either editing an existing note, or creating a new one with an anchor.
    private let existing: Note?
    private let anchorKind: NoteAnchorKind
    private let anchorRefId: String?
    private let anchorLabel: String?

    @State private var title: String
    @State private var bodyText: String

    init(existing: Note) {
        self.existing = existing
        self.anchorKind = existing.anchorKind
        self.anchorRefId = existing.anchorRefId
        self.anchorLabel = existing.anchorLabel
        _title = State(initialValue: existing.title)
        _bodyText = State(initialValue: existing.body)
    }

    init(anchorKind: NoteAnchorKind, anchorRefId: String? = nil, anchorLabel: String? = nil, prefilledBody: String = "") {
        self.existing = nil
        self.anchorKind = anchorKind
        self.anchorRefId = anchorRefId
        self.anchorLabel = anchorLabel
        _title = State(initialValue: "")
        _bodyText = State(initialValue: prefilledBody)
    }

    var body: some View {
        NavigationStack {
            Form {
                if let anchorLabel, !anchorLabel.isEmpty {
                    Section("Attached to") {
                        HStack {
                            Badge(text: anchorKind.rawValue, color: Theme.accent)
                            Text(anchorLabel).font(.subheadline).foregroundStyle(.secondary)
                        }
                    }
                }
                Section("Title") {
                    TextField("Note title", text: $title)
                }
                Section("Note") {
                    TextField("Write your note…", text: $bodyText, axis: .vertical)
                        .lineLimit(5...15)
                }
            }
            .navigationTitle(existing == nil ? "New Note" : "Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") { save() }
                        .fontWeight(.semibold)
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty && bodyText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func save() {
        if let existing {
            existing.title = title
            existing.body = bodyText
        } else {
            let note = Note(
                title: title.isEmpty ? defaultTitle : title,
                body: bodyText,
                anchorKind: anchorKind,
                anchorRefId: anchorRefId,
                anchorLabel: anchorLabel
            )
            context.insert(note)
        }
        dismiss()
    }

    private var defaultTitle: String {
        anchorLabel ?? "Note"
    }
}

#Preview {
    NavigationStack { NotesView() }
        .modelContainer(for: Note.self, inMemory: true)
}

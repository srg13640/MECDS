import Foundation
import SwiftData

/// A user note stored locally on device via SwiftData. No login required.
///
/// A note can be anchored to a process step, an organization, a glossary term,
/// a capability-path scenario, or be general. The anchor is stored as a string
/// kind plus an optional reference id/title so the note can deep-link back.
@Model
final class Note {
    var id: UUID
    var title: String
    var body: String
    var anchorKindRaw: String
    /// Optional id of the anchored content item (e.g. a process step id).
    var anchorRefId: String?
    /// Human-readable label of the anchor (e.g. "Step 3: Functional problem ownership").
    var anchorLabel: String?
    var createdAt: Date

    init(
        title: String,
        body: String,
        anchorKind: NoteAnchorKind = .general,
        anchorRefId: String? = nil,
        anchorLabel: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.anchorKindRaw = anchorKind.rawValue
        self.anchorRefId = anchorRefId
        self.anchorLabel = anchorLabel
        self.createdAt = Date()
    }

    var anchorKind: NoteAnchorKind {
        NoteAnchorKind(rawValue: anchorKindRaw) ?? .general
    }
}

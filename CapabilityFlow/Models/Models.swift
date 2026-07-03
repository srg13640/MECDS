import Foundation

// MARK: - Core content models
//
// All content models are plain `Codable`/`Identifiable` value types so the app
// stays local-first and the entire knowledge base can live in one central data
// file (`AppData.swift`). Add new steps, organizations, glossary terms, matrix
// entries, scenarios, or quiz questions there without touching the views.

/// A single stage in the capability-development journey.
struct ProcessStep: Identifiable, Codable, Hashable {
    let id: String
    let number: Int
    let title: String
    let shortDescription: String
    let detailedDescription: String
    /// Organization abbreviations involved in this step.
    let organizations: [String]
    let outputs: [String]
    let frictionPoints: [String]
    let keyQuestions: [String]
    /// IDs of steps this one typically flows into (often non-linear / looping).
    let nextSteps: [String]
}

/// A category used to group organizations in the explorer.
enum OrgCategory: String, Codable, CaseIterable, Identifiable {
    case concepts = "Concepts & Futures"
    case functional = "Functional Problem Owners"
    case combinedArms = "Combined Arms & Proponents"
    case scienceTech = "Science & Technology"
    case experimentation = "Experimentation"
    case analysis = "Analysis & Evidence"
    case requirements = "Requirements"
    case resourcing = "Resourcing"
    case acquisition = "Acquisition"
    case test = "Test & Evaluation"
    case sustainment = "Sustainment & Fielding"
    case operational = "Operational Force"

    var id: String { rawValue }
}

/// An organization in the capability-development enterprise.
struct Organization: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let abbreviation: String
    let category: OrgCategory
    let plainEnglishRole: String
    let owns: [String]
    let doesNotOwn: [String]
    let keyRelationships: [String]
    let typicalOutputs: [String]
    let whenToInvolve: String
    /// IDs of related process steps for internal deep linking.
    let relatedProcessSteps: [String]
    /// Optional statutory or authoritative source citation (e.g. "10 U.S.C. §7016").
    var statutoryBasis: String? = nil

    /// Searchable text blob.
    var searchText: String {
        "\(name) \(abbreviation) \(category.rawValue) \(plainEnglishRole)".lowercased()
    }
}

/// A glossary term.
struct GlossaryTerm: Identifiable, Codable, Hashable {
    let id: String
    let term: String
    let definition: String
    let whyItMatters: String
    let example: String
    /// Optional statutory or authoritative source citation (e.g. "10 U.S.C. §181").
    var statutoryBasis: String? = nil

    var searchText: String {
        "\(term) \(definition)".lowercased()
    }
}

// MARK: - Responsibility matrix

/// The process functions that form the columns of the "Who Does What" matrix.
enum ProcessFunction: String, Codable, CaseIterable, Identifiable {
    case concepts = "Concepts"
    case dotmlpfp = "DOTMLPF-P"
    case experimentation = "Experimentation"
    case scienceTech = "S&T"
    case analysis = "Analysis"
    case requirements = "Requirements"
    case resourcing = "Resourcing"
    case acquisition = "Acquisition"
    case testing = "Testing"
    case fielding = "Fielding"
    case feedback = "Feedback"

    var id: String { rawValue }
}

/// The level of responsibility an organization has for a function.
enum ResponsibilityLevel: String, Codable, CaseIterable, Identifiable {
    case lead = "Lead"
    case support = "Support"
    case inform = "Inform"
    case receive = "Receive"

    var id: String { rawValue }

    /// Short single-letter indicator for compact matrix cells.
    var indicator: String {
        switch self {
        case .lead: return "L"
        case .support: return "S"
        case .inform: return "I"
        case .receive: return "R"
        }
    }
}

struct MatrixEntry: Identifiable, Codable, Hashable {
    var id: String { "\(organizationId)-\(function.rawValue)" }
    let organizationId: String
    let function: ProcessFunction
    let responsibilityLevel: ResponsibilityLevel
}

// MARK: - Glossary / note linking

/// What a saved note is attached to. Stored as a string in the persisted note.
enum NoteAnchorKind: String, Codable, CaseIterable, Identifiable {
    case processStep = "Process Step"
    case organization = "Organization"
    case glossaryTerm = "Glossary Term"
    case scenario = "Capability Path"
    case general = "General"

    var id: String { rawValue }
}

// MARK: - Quiz

struct QuizQuestion: Identifiable, Codable, Hashable {
    let id: String
    let category: String
    let prompt: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
}

// MARK: - Build-a-Path wizard

/// Options for the wizard. Kept simple so answers map cleanly to recommendations.
enum SolutionType: String, Codable, CaseIterable, Identifiable {
    case materiel = "Materiel"
    case nonMateriel = "Non-materiel"
    case both = "Both"
    var id: String { rawValue }
}

enum Urgency: String, Codable, CaseIterable, Identifiable {
    case urgent = "Urgent"
    case deliberate = "Deliberate"
    var id: String { rawValue }
}

enum TriState: String, Codable, CaseIterable, Identifiable {
    case yes = "Yes"
    case no = "No"
    case unsure = "Unsure"
    var id: String { rawValue }
}

/// The user's answers, fed into the recommendation engine.
struct CapabilityAnswers {
    var problemStatement: String = ""
    var warfightingFunction: String = "Command & Control"
    var solutionType: SolutionType = .both
    var jointInteroperability: TriState = .unsure
    var technologyMature: TriState = .unsure
    var existingSolution: TriState = .unsure
    var experimentationNeeded: TriState = .yes
    var dotmlpfpImplications: TriState = .yes
    var fundingNeeded: TriState = .yes
    var urgency: Urgency = .deliberate
}

/// The generated, human-readable recommendation.
struct CapabilityRecommendation {
    let organizations: [String]
    let firstActions: [String]
    let likelyArtifacts: [String]
    let keyRisks: [String]
    let battleRhythm: [String]
    let narrative: String
}

/// Warfighting functions used by the wizard picker.
let warfightingFunctions = [
    "Command & Control",
    "Movement & Maneuver",
    "Intelligence",
    "Fires",
    "Sustainment",
    "Protection",
    "Information / Cyber"
]

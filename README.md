# Capability Flow

**Understand the Army capability-development ecosystem.**

Capability Flow is an iPhone-first, local-first SwiftUI app that teaches users how
Army / Department of War capability development now works as an end-to-end
*ecosystem* — who does what, when they get involved, what artifacts they produce,
and how a capability moves from operational problem to fielded solution and back
through feedback.

> **Key idea:** Capability development is an *operational problem → portfolio →
> evidence loop* — not a linear requirements-document-to-program pipeline.

> ⚠️ **Educational tool only.** Organizations, roles, and authorities evolve. This
> app is not an authoritative policy system. Verify current guidance against
> official source material before acting. The content uses deliberately careful
> language ("typically", "generally", "in the emerging model").

---

## Features (MVP)

| Screen | What it does |
| --- | --- |
| **Home** | Three large entry cards (Explore the Process, Who Does What, Build a Capability Path), a "Key Idea" section, quick links to Organizations / Glossary / Quiz / Notes, onboarding, and a policy caveat banner. |
| **Process** | The 13-step capability-development loop as a tappable vertical timeline. Each step opens a detail panel: what happens, primary organizations (deep-linked), key outputs, friction points, questions to ask, and where it flows next. |
| **Organizations** | Searchable, category-filterable directory of 25 organizations. Each has a plain-English role, what they own / don't own, key relationships, typical outputs, when to involve them, and links to related process steps. |
| **Matrix** | "Who Does What" responsibility matrix (organizations × 11 functions) with Lead / Support / Inform / Receive indicators. Filter by function to focus. |
| **Build** | A wizard that turns answers about a hypothetical capability into a recommended path: organizations to involve, first five staff actions, likely artifacts, key risks, and a recommended battle rhythm. Save the result as a note. |
| **Glossary** | 33 searchable terms, each with a plain-English definition, why it matters, and an example sentence. |
| **Training Quiz** | 12 scenario-based questions with immediate feedback and explanations. |
| **Saved Notes** | Create, view, edit, and delete notes locally (SwiftData). Notes can be anchored to a process step, organization, glossary term, or a capability path. |

Other: light & dark mode, portrait-first, professional muted "staff" aesthetic,
internal deep links between organizations and process steps, role-based learning
primers in onboarding, and a policy-caveat banner (stretch goals included).

---

## Requirements

- **macOS** with **Xcode 16 or later** (the project uses Xcode 16
  file-system-synchronized groups, `objectVersion = 77`).
- iOS **17.0+** simulator or device (SwiftData is used for local notes).

## Run it on the iPhone simulator

From Xcode (simplest):

1. Open `CapabilityFlow.xcodeproj`.
2. Select the **CapabilityFlow** scheme and an iPhone simulator (e.g. *iPhone 15*).
3. Press **⌘R**.

From the command line:

```bash
# List available simulators
xcrun simctl list devices available

# Build for a simulator
xcodebuild -project CapabilityFlow.xcodeproj \
  -scheme CapabilityFlow \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  build

# Or: open in Xcode and press Run
open CapabilityFlow.xcodeproj
```

No backend, accounts, or network access are required. All content is hard-coded
local data and all notes are stored on-device.

---

## Architecture

```
CapabilityFlow.xcodeproj          # Xcode 16 project (file-system-synchronized)
CapabilityFlow/
├── CapabilityFlowApp.swift       # @main entry; installs the SwiftData container
├── ContentView.swift             # TabView: Process · Organizations · Matrix · Build · Glossary
├── Models/
│   └── Models.swift              # ProcessStep, Organization, GlossaryTerm, MatrixEntry, QuizQuestion, wizard types
├── Data/
│   ├── AppData.swift             # ★ SINGLE SOURCE OF TRUTH for all content
│   └── RecommendationEngine.swift# Transparent rules engine for the Build wizard
├── Persistence/
│   └── Note.swift                # SwiftData @Model for local notes
├── Theme/
│   └── Theme.swift               # Muted palette, cards, badges, bullet sections
└── Views/
    ├── Router.swift              # Tab selection + deep-link destinations
    ├── HomeView.swift            # Landing screen (presented over the tab bar)
    ├── ProcessViews.swift        # Timeline list + step detail
    ├── OrganizationViews.swift   # Explorer list + org detail
    ├── MatrixView.swift          # Responsibility matrix + function focus
    ├── BuildPathView.swift       # Wizard + recommendation result
    ├── GlossaryViews.swift       # Glossary list + term detail
    ├── QuizView.swift            # Training quiz
    ├── NotesViews.swift          # Notes list + editor
    ├── OnboardingView.swift      # New-personnel onboarding + role paths
    └── FlexibleWrap.swift        # Wrapping (tag-cloud) layout
```

### Design principles

- **Local-first / no backend.** Content is in Swift value types; notes use SwiftData.
- **One central data file.** Add or correct content in `Data/AppData.swift` only.
- **Modular & extensible.** New steps, organizations, terms, matrix entries, scenarios,
  and quiz questions are just new array entries — views read everything through
  `AppData.shared`.
- **Deep links.** Process steps, organizations, and glossary terms are `Hashable`
  values pushed via `NavigationLink(value:)`, with destinations registered once in
  `Router.swift` (`CommonDestinations`).

## How to extend the content

Everything lives in `Data/AppData.swift`:

- **Add a process step** → append a `ProcessStep` to `processSteps` (give it a unique
  `id`, set `number`, and reference real `nextSteps` ids).
- **Add an organization** → append an `Organization` to `organizations` (unique `id`,
  pick an `OrgCategory`, and list `relatedProcessSteps`).
- **Add a glossary term** → append a `GlossaryTerm` to `glossary`.
- **Add a matrix mapping** → add a row to `buildMatrix()` (org id → `(function, level)`).
- **Add a quiz question** → append a `QuizQuestion` to `quizQuestions`.
- **Tune the wizard** → edit the rules in `Data/RecommendationEngine.swift`.

## Notes on accuracy

This app reflects an *emerging* model of distributed, iterative capability
development. It intentionally emphasizes that FCC/FCDs do **not** replace CAC,
DEVCOM, HQDA G-8, ASA(ALT), PEOs/PMs, or ATEC — each owns part of a shared
problem. Names, abbreviations, and authorities change; treat this as a learning
aid and confirm specifics against current official guidance.

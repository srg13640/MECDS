import Foundation

/// Generates a recommended capability path from the wizard answers.
///
/// This is a deliberately simple, transparent rules engine — it is meant to be
/// educational and easy to edit, not authoritative. Language stays hedged
/// ("typically", "consider", "depending on guidance").
enum RecommendationEngine {

    static func recommend(from a: CapabilityAnswers) -> CapabilityRecommendation {
        var orgs: [String] = []
        var actions: [String] = []
        var artifacts: [String] = []
        var risks: [String] = []
        var rhythm: [String] = []

        // 1. Always start with concepts + the right functional owner.
        let fcd = functionalOwner(for: a.warfightingFunction)
        orgs.append(contentsOf: [fcd, "FCC Directorate of Concepts (DoC)"])
        actions.append("Frame the operational problem with \(fcd) and DoC — state it as a problem, not a solution.")
        artifacts.append("Operational problem statement / capability gap")

        // 2. DOTMLPF-P check.
        if a.solutionType != .materiel || a.dotmlpfpImplications != .no {
            orgs.append("CAC TID (DOTMLPF-P integration)")
            actions.append("Engage CAC TID to test whether this is a materiel or DOTMLPF-P gap, and identify non-materiel changes.")
            artifacts.append("DOTMLPF-P implications assessment")
        }

        // 3. S&T feasibility for materiel/both, especially if tech immature.
        if a.solutionType != .nonMateriel {
            let stOrg = a.warfightingFunction.contains("Cyber") || a.warfightingFunction.contains("Command")
                ? "DEVCOM C5ISR Center"
                : "DEVCOM"
            orgs.append(stOrg)
            actions.append("Ask \(stOrg) for a technical feasibility and technology maturity assessment.")
            artifacts.append("Technical feasibility assessment")
            if a.technologyMature == .no {
                risks.append("Technology may not be mature — writing requirements too early risks an undeliverable program.")
            }
            if a.existingSolution == .yes {
                actions.append("Check commercial / existing prototype options before assuming new development is required.")
            }
        }

        // 4. Experimentation.
        if a.experimentationNeeded != .no {
            orgs.append("JMC (experimentation)")
            actions.append("Coordinate with JMC to experiment with Soldiers and capture honest feedback.")
            artifacts.append("Experimentation / Soldier feedback results")
        } else {
            risks.append("Skipping experimentation risks committing resources to an unvalidated concept.")
        }

        // 5. Analysis.
        orgs.append("TDAC (analysis)")
        artifacts.append("Operational analysis / evidence")

        // 6. Requirements integration.
        orgs.append(contentsOf: ["FCC FID", "HQDA G-8 Force Development"])
        artifacts.append("Requirements documentation (e.g., ICD / CDD / A-CDD)")

        // 7. Joint.
        if a.jointInteroperability == .yes {
            orgs.append("Joint Staff (JCIDS / Joint validation)")
            actions.append("Engage the Joint Staff early — Joint interoperability shapes the validation path (e.g., JCIDS / JROC).")
            risks.append("Joint validation can extend timelines and add coordination overhead.")
        }

        // 8. Resourcing.
        if a.fundingNeeded != .no {
            orgs.append("HQDA G-8 / PAE (resourcing)")
            artifacts.append("Affordability analysis / POM input")
            risks.append("A validated requirement with no resourcing path stalls — plan the POM/PPBE engagement.")
        }

        // 9. Acquisition + test + fielding.
        if a.solutionType != .nonMateriel {
            orgs.append(contentsOf: ["ASA(ALT) / PEO-PM", "ATEC (test)", "AMC (fielding & sustainment)"])
            artifacts.append("Acquisition strategy and pathway selection")
            artifacts.append("Test & evaluation and fielding plans")
        }

        // 10. Feedback always closes the loop.
        actions.append("Plan the feedback loop now — define how units, CTCs, and lessons-learned will refine the next cycle.")
        artifacts.append("Lessons-learned / feedback plan")

        // Urgency shapes battle rhythm and pathway.
        if a.urgency == .urgent {
            rhythm = [
                "Stand up a small cross-org working group meeting weekly.",
                "Compress experimentation and analysis into focused sprints.",
                "Consider faster pathways (e.g., MTA rapid prototyping / fielding, Software Acquisition Pathway) — depending on guidance.",
                "Brief decision-makers on a short, recurring cycle to keep momentum."
            ]
            risks.append("Speed pressure can tempt the team to skip evidence — keep at least minimal experimentation and analysis.")
        } else {
            rhythm = [
                "Establish a monthly cross-organization sync across the involved organizations.",
                "Sequence experimentation → analysis → requirements deliberately, with decision gates.",
                "Align requirements maturity to the POM/PPBE calendar.",
                "Hold a quarterly portfolio review with the PAE once acquisition is engaged."
            ]
        }

        if a.dotmlpfpImplications == .yes {
            risks.append("Non-materiel changes (doctrine, training, organization) often lag materiel — assign owners early.")
        }

        // De-duplicate while preserving order.
        let recOrgs = dedupe(orgs)
        let firstFive = Array(dedupe(actions).prefix(5))

        let narrative = buildNarrative(a: a, fcd: fcd)

        return CapabilityRecommendation(
            organizations: recOrgs,
            firstActions: firstFive,
            likelyArtifacts: dedupe(artifacts),
            keyRisks: dedupe(risks),
            battleRhythm: rhythm,
            narrative: narrative
        )
    }

    private static func functionalOwner(for function: String) -> String {
        switch function {
        case "Command & Control": return "C2 FCD"
        case "Movement & Maneuver": return "Maneuver FCD"
        case "Intelligence": return "Intelligence FCD"
        case "Fires": return "Fires FCD"
        case "Sustainment": return "Sustainment FCD"
        case "Protection": return "Protection FCD"
        case "Information / Cyber": return "Cyber FCD"
        default: return "the relevant FCD"
        }
    }

    private static func buildNarrative(a: CapabilityAnswers, fcd: String) -> String {
        var s = "For this problem, start with \(fcd) and the Directorate of Concepts (DoC) to frame the operational problem"
        if a.solutionType != .materiel || a.dotmlpfpImplications != .no {
            s += ", involve CAC TID for DOTMLPF-P implications"
        }
        if a.solutionType != .nonMateriel {
            let st = a.warfightingFunction.contains("Cyber") || a.warfightingFunction.contains("Command") ? "DEVCOM C5ISR" : "DEVCOM"
            s += ", engage \(st) for technical feasibility"
        }
        if a.experimentationNeeded != .no {
            s += ", coordinate with JMC for experimentation"
        }
        s += ", use TDAC for analysis, and involve FCC FID / HQDA G-8 FD before drafting formal requirements"
        if a.fundingNeeded != .no {
            s += ", then work resourcing through HQDA G-8 / the PAE"
        }
        if a.solutionType != .nonMateriel {
            s += ", with ASA(ALT)/PEO-PM for acquisition, ATEC for test, and AMC for fielding and sustainment"
        }
        s += a.urgency == .urgent
            ? ". Given urgency, compress the cycle and consider faster acquisition pathways, depending on guidance."
            : ". Run this deliberately, aligned to the POM/PPBE calendar."
        s += " Remember: this is a loop — plan the feedback path now."
        return s
    }

    private static func dedupe(_ arr: [String]) -> [String] {
        var seen = Set<String>()
        return arr.filter { seen.insert($0).inserted }
    }
}

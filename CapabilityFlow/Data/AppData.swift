import Foundation

// MARK: - Central content store
//
// This is the single source of truth for all educational content in
// Capability Flow. To add or correct content, edit ONLY this file. The views
// read everything through `AppData.shared`.
//
// CONTENT CAVEAT: This app is an educational tool, not an authoritative policy
// system. Roles described here reflect the emerging Army / Department of War
// capability-development model and use deliberately careful language
// ("typically", "generally", "in the emerging model", "depending on authority
// and guidance"). Always verify current authorities, names, and guidance
// against official source material.

struct AppData {
    static let shared = AppData()

    let policyCaveat = "Educational tool only. Organizations, roles, and authorities evolve. Verify current guidance against official source material before acting."

    let keyIdea = "Capability development is an operational problem → portfolio → evidence loop — not a linear requirements-document-to-program pipeline."

    // MARK: Process steps

    let processSteps: [ProcessStep] = [
        ProcessStep(
            id: "s1",
            number: 1,
            title: "Strategic direction / operational problem",
            shortDescription: "Senior leaders and combatant commands frame the problem worth solving.",
            detailedDescription: "Everything starts with a validated operational problem and strategic direction. Department of War and Army senior leaders, combatant commands (CCMDs), and the Joint Staff set priorities and articulate the operational problems the force must solve. In the emerging model this is less about a single document and more about a shared understanding of what matters most. This problem-first framing is now statutory: under 10 U.S.C. §181, the JROC's mission includes compiling, refining, and prioritizing joint operational problems and recommending nonprescriptive solutions to them.",
            organizations: ["DoW/DoD", "Army Senior Leaders", "CCMDs", "Joint Staff", "HQDA"],
            outputs: ["Strategic guidance", "Operational problem statement", "Priorities", "Joint Operational Problems", "Army transformation priorities"],
            frictionPoints: ["Problems stated as solutions ('we need X') rather than as problems", "Unclear whether the problem is Army-only or Joint", "Competing priorities with no clear ranking"],
            keyQuestions: ["What problem are we actually solving?", "Who has validated that it matters?", "Is this Army-only or Joint?"],
            nextSteps: ["s2", "s3"]
        ),
        ProcessStep(
            id: "s2",
            number: 2,
            title: "Future-force framing",
            shortDescription: "Concepts describe how the future Army needs to fight.",
            detailedDescription: "The problem is placed in the context of the future operating environment. T2COM and the Futures and Concepts Command (FCC) — through its Directorate of Concepts (DoC) — translate strategic direction into concepts that describe how the future Army needs to fight. DoC informs forward-focused Army concepts to design the Army of 2040, produces the Future Warfighting Concepts, and represents the Army in developing Joint Warfighting Concepts. This step surfaces the assumptions that everything downstream will depend on.",
            organizations: ["T2COM", "FCC", "Directorate of Concepts"],
            outputs: ["Future operational environment assessment", "Army concepts", "Future Warfighting Concepts"],
            frictionPoints: ["Assumptions left implicit and never tested", "Concepts disconnected from what is technically or fiscally feasible"],
            keyQuestions: ["How does the future Army need to fight?", "What assumptions are we making?", "Which assumptions, if wrong, break the concept?"],
            nextSteps: ["s3"]
        ),
        ProcessStep(
            id: "s3",
            number: 3,
            title: "Functional problem ownership",
            shortDescription: "An FCD takes ownership of the functional problem and gaps.",
            detailedDescription: "A Future Capability Directorate (FCD) takes primary ownership of the functional problem and frames it as capability gaps and learning demands. The nine FCDs — Aviation, C2, Cyber, Fires, Formation Based Layered Protection (FBLP), Intelligence, Maneuver, Medical, and Sustainment — are subordinate to FCC and drive functional transformation by informing concepts, requirements, and experimentation. Other FCDs are identified as supporting or affected. Clear ownership here prevents the most common failure mode downstream: no one accountable for the problem as a whole.",
            organizations: ["FCDs", "C2 FCD", "Cyber FCD", "Fires FCD", "Intelligence FCD", "Maneuver FCD", "Aviation FCD", "Sustainment FCD", "Medical FCD", "FBLP FCD"],
            outputs: ["Functional modernization problems", "Capability gaps", "Learning demands", "Concept-required capabilities"],
            frictionPoints: ["Two FCDs each assume the other owns it", "Cross-functional problems with no integrating owner"],
            keyQuestions: ["Which FCD owns the primary problem?", "Which FCDs are supporting or affected?", "Who integrates across the FCDs?"],
            nextSteps: ["s4", "s5"]
        ),
        ProcessStep(
            id: "s4",
            number: 4,
            title: "DOTMLPF-P and proponent integration",
            shortDescription: "Determine what must change beyond equipment.",
            detailedDescription: "The Combined Arms Command (CAC), CAC TID, Centers of Excellence, and proponents examine the problem across all DOTMLPF-P domains. A surprising number of 'materiel gaps' are actually doctrine, organization, or training gaps. This step keeps the enterprise from buying equipment to solve a problem that a change in how we operate would solve faster and cheaper.",
            organizations: ["CAC", "CAC TID", "Centers of Excellence", "Proponents"],
            outputs: ["Doctrine implications", "Organization implications", "Training implications", "Materiel implications", "Leadership/education implications", "Personnel implications", "Facilities implications", "Policy implications"],
            frictionPoints: ["Defaulting to a materiel solution before checking non-materiel options", "Materiel fielded with no doctrine or training to employ it"],
            keyQuestions: ["Is this actually a materiel gap, or a DOTMLPF-P gap?", "What must change besides equipment?", "Who owns each non-materiel change?"],
            nextSteps: ["s5", "s8"]
        ),
        ProcessStep(
            id: "s5",
            number: 5,
            title: "S&T / technical feasibility",
            shortDescription: "Assess whether a solution is technically possible and mature.",
            detailedDescription: "DEVCOM, ARL, MRDC, the C5ISR Center, industry, and innovation partners assess technical feasibility and technology maturity, and may build prototypes. This grounds the concept in what is actually buildable now versus what needs investment, and reveals what industry can already provide.",
            organizations: ["DEVCOM", "ARL", "MRDC", "C5ISR Center", "Industry", "Innovation partners"],
            outputs: ["Technical feasibility assessment", "Prototypes", "S&T roadmap", "Technology maturity insights"],
            frictionPoints: ["Requirements written for technology that is not yet mature", "Ignoring commercial solutions already on the market"],
            keyQuestions: ["Is the solution technically possible?", "Is the technology mature?", "What can industry already provide?"],
            nextSteps: ["s6"]
        ),
        ProcessStep(
            id: "s6",
            number: 6,
            title: "Experimentation and Soldier feedback",
            shortDescription: "Put concepts and prototypes in front of Soldiers.",
            detailedDescription: "The Joint Modernization Command (JMC), Project Convergence, FCC experimentation, operational units, and the CTCs put concepts and prototypes in front of Soldiers and commanders. The purpose is learning, not validation theater: did the idea survive contact with reality?",
            organizations: ["JMC", "Project Convergence", "FCC Experimentation", "Operational units", "CTCs"],
            outputs: ["Learning results", "User feedback", "Prototype assessment", "Military utility insights"],
            frictionPoints: ["Experiments designed to confirm rather than to learn", "Soldier feedback collected but never analyzed or acted on"],
            keyQuestions: ["What did Soldiers and commanders actually say?", "Did the concept survive contact with reality?", "What did we learn that we did not expect?"],
            nextSteps: ["s7"]
        ),
        ProcessStep(
            id: "s7",
            number: 7,
            title: "Analysis and evidence",
            shortDescription: "Turn observations into rigorous evidence.",
            detailedDescription: "TDAC, CAA, ORSAs, ATEC, and analysts turn experimentation observations and data into rigorous evidence through operational analysis, modeling and simulation, and risk assessment. This is where assumptions are confirmed or disproven before the enterprise commits resources.",
            organizations: ["TDAC", "CAA", "ORSAs", "ATEC", "Analysts"],
            outputs: ["Operational analysis", "Modeling and simulation", "Formation effectiveness analysis", "Performance data", "Risk assessment"],
            frictionPoints: ["Decisions made ahead of the analysis", "Cherry-picking evidence that supports a preferred answer"],
            keyQuestions: ["What does the evidence actually show?", "What assumptions were disproven?", "How confident are we, and where is the risk?"],
            nextSteps: ["s8"]
        ),
        ProcessStep(
            id: "s8",
            number: 8,
            title: "Requirements integration",
            shortDescription: "Translate evidence into justified, minimal requirements.",
            detailedDescription: "The FCC Futures Integration Directorate (FID), FCD requirements writers, HQDA G-8 Force Development, and CAC/proponents translate evidence into formal requirements. The discipline here is writing the minimum viable requirement that the evidence justifies — not a wish list.",
            organizations: ["FCC FID", "FCD requirements writers", "HQDA G-8 FD", "CAC/Proponents"],
            outputs: ["Validated gaps", "CBAs / TBAs", "CDDs", "A-CDDs", "ICDs", "CONOPS", "Requirements documentation"],
            frictionPoints: ["Gold-plating requirements beyond what evidence supports", "Requirements that no acquisition pathway can realistically deliver"],
            keyQuestions: ["What requirement is justified by evidence?", "What is the minimum viable requirement?", "Is this requirement testable and affordable?"],
            nextSteps: ["s9"]
        ),
        ProcessStep(
            id: "s9",
            number: 9,
            title: "Resourcing and prioritization",
            shortDescription: "Decide what the Army can afford and what it displaces.",
            detailedDescription: "HQDA G-8, the PAE, the PEGs, the PPBC, the SRG, and ASA(FM&C) decide what fits in the Army Program and the FYDP. Every funded capability displaces something else; this step makes those trade-offs explicit.",
            organizations: ["HQDA G-8", "PAE", "PEGs", "PPBC", "SRG", "ASA(FM&C)"],
            outputs: ["Army Program", "FYDP alignment", "Affordability analysis", "Prioritization decisions"],
            frictionPoints: ["Requirements approved with no resourcing path", "Underestimating sustainment and lifecycle cost"],
            keyQuestions: ["Can the Army afford this?", "What is displaced if this is funded?", "Is the full lifecycle cost accounted for?"],
            nextSteps: ["s10"]
        ),
        ProcessStep(
            id: "s10",
            number: 10,
            title: "Acquisition portfolio execution",
            shortDescription: "Select a pathway and execute with portfolio accountability.",
            detailedDescription: "ASA(ALT), PAEs, CPEs, PEOs, PMs, and contracting officials execute the acquisition. In the emerging model, portfolio accountability (PAEs/CPEs) sits alongside program execution (PEOs/PMs), and pathway selection is matched to the type of capability and how fast it must move.",
            organizations: ["ASA(ALT)", "PAEs", "CPEs", "PEOs", "PMs", "Contracting officials"],
            outputs: ["Acquisition strategy", "Pathway selection", "Contracts", "Prototypes", "Production plans"],
            frictionPoints: ["Choosing a slow pathway for an urgent need (or vice versa)", "Program execution without portfolio-level trade-off visibility"],
            keyQuestions: ["What acquisition pathway fits?", "Who has portfolio accountability?", "How does this fit the broader portfolio?"],
            nextSteps: ["s11"]
        ),
        ProcessStep(
            id: "s11",
            number: 11,
            title: "Test and continuous evaluation",
            shortDescription: "Continuously test for effectiveness, suitability, and safety.",
            detailedDescription: "ATEC, PAE test integrators, and operational units test for operational effectiveness, suitability, and safety. In the emerging model, test is continuous and integrated with development rather than a single gate at the end, with Soldier-validated feedback throughout.",
            organizations: ["ATEC", "PAE test integrators", "Operational units"],
            outputs: ["Test data", "Soldier-validated feedback", "Safety releases", "Operational effectiveness and suitability findings"],
            frictionPoints: ["Test treated as a final gate instead of continuous", "Discovering integration problems too late to fix cheaply"],
            keyQuestions: ["What must be tested before scaling?", "What risks remain?", "Is it effective, suitable, and safe for Soldiers?"],
            nextSteps: ["s12"]
        ),
        ProcessStep(
            id: "s12",
            number: 12,
            title: "Fielding, sustainment, and formation integration",
            shortDescription: "Make sure units can absorb, train, maintain, and employ it.",
            detailedDescription: "AMC, ASC, the Army Service Component Commands (ASCCs), gaining units, CAC, T2COM, and the sustainment enterprise field the capability and integrate it into formations — with the training, doctrine, and sustainment needed to actually use it. A capability that units cannot absorb is not really fielded.",
            organizations: ["AMC", "ASC", "ASCCs", "Gaining units", "CAC", "T2COM", "Sustainment enterprise"],
            outputs: ["Fielding plans", "Training", "Doctrine updates", "Sustainment plans", "Formation integration"],
            frictionPoints: ["Equipment fielded faster than units can absorb it", "No sustainment plan, so capability degrades after fielding"],
            keyQuestions: ["Can units actually absorb, train, maintain, and employ this?", "Is the sustainment tail funded?", "What doctrine and training must change?"],
            nextSteps: ["s13"]
        ),
        ProcessStep(
            id: "s13",
            number: 13,
            title: "Feedback loop",
            shortDescription: "Learn from the field and feed the next cycle.",
            detailedDescription: "Operational units, CTCs, exercises, and lessons-learned processes feed insights back to FCC, CAC, G-8, and ASA(ALT). This closes the loop: the field teaches the enterprise, concepts and requirements are refined, and the next iteration begins. The process is a loop, not a finish line.",
            organizations: ["Operational units", "CTCs", "Exercises", "Lessons learned", "FCC", "CAC", "G-8", "ASA(ALT)"],
            outputs: ["Lessons learned", "Updated concepts", "Refined requirements", "Modernization adjustments"],
            frictionPoints: ["Lessons collected but never fed back into concepts or requirements", "Treating fielding as the end of the story"],
            keyQuestions: ["What did the field teach us?", "What must change in the next cycle?", "Which assumptions from Step 2 turned out to be wrong?"],
            nextSteps: ["s1", "s2", "s3"]
        )
    ]

    // MARK: Organizations

    let organizations: [Organization] = [
        Organization(
            id: "fcc",
            name: "Futures and Concepts Command",
            abbreviation: "FCC",
            category: .concepts,
            plainEnglishRole: "Designs the future force by developing integrated concepts and requirements, informed by experimentation, and synchronized into T2COM and Army processes to drive persistent Army modernization. Executes four core functions: concepts, experimentation, requirements, and integration — aimed at the Army needed 5 to 15 years out.",
            owns: ["Core functions: concepts, experimentation, requirements, integration", "The nine Future Capability Directorates (FCDs)", "Subordinate commands: DEVCOM, MRDC, TDAC, JMC, 75th USARIC"],
            doesNotOwn: ["Acquisition execution", "Resourcing decisions", "Operational test", "Doctrine and training (CAC)"],
            keyRelationships: ["T2COM (higher headquarters)", "CAC", "HQDA G-8", "ASA(ALT)", "DEVCOM", "JMC", "TDAC"],
            typicalOutputs: ["Concepts", "Capability gaps", "Requirements documentation", "Experimentation campaigns"],
            whenToInvolve: "Early — whenever a future operational problem or capability gap is being framed.",
            relatedProcessSteps: ["s2", "s3", "s6", "s8", "s13"],
            statutoryBasis: "Why FCC informs requirements but does not execute acquisition: 10 U.S.C. §7014(c)(1) reserves the acquisition function to the Office of the Secretary of the Army (ASA(ALT)), and 10 U.S.C. §7013(b)(4) makes the Secretary of the Army responsible for equipping, including research and development."
        ),
        Organization(
            id: "doc",
            name: "FCC Directorate of Concepts",
            abbreviation: "DoC",
            category: .concepts,
            plainEnglishRole: "Informs forward-focused Army concepts to design the Army of 2040 and produces the Future Warfighting Concepts. Represents the Army in the development of Joint Warfighting Concepts, which describe how the Joint Force will operate in the future operating environment.",
            owns: ["Future Warfighting Concepts", "Forward-focused Army concepts (Army of 2040)", "Army representation in Joint Warfighting Concept development"],
            doesNotOwn: ["Requirements documents", "Resourcing", "Acquisition"],
            keyRelationships: ["FCC", "FCDs", "CAC", "T2COM"],
            typicalOutputs: ["Future Warfighting Concepts", "Operating environment assessments"],
            whenToInvolve: "At the very front, to frame the future-force context and surface assumptions.",
            relatedProcessSteps: ["s2"]
        ),
        Organization(
            id: "fid",
            name: "FCC Futures Integration Directorate",
            abbreviation: "FID",
            category: .requirements,
            plainEnglishRole: "Supports Army transformation by identifying, synchronizing, and prioritizing requirements for FCC and Army processes. Identifies and documents Army capability gaps, analyzes and integrates emerging materiel requirements, and synchronizes materiel solution resources across the capability development community of practice.",
            owns: ["Identifying and documenting Army capability gaps", "Analyzing and integrating emerging materiel requirements", "Synchronizing materiel solution resources", "Requirements prioritization across FCDs"],
            doesNotOwn: ["Resourcing decisions", "Acquisition execution"],
            keyRelationships: ["FCDs", "HQDA G-8 FD", "CAC", "TDAC"],
            typicalOutputs: ["Integrated requirements documents", "CDDs / A-CDDs / ICDs coordination"],
            whenToInvolve: "When evidence is mature enough to translate into formal requirements.",
            relatedProcessSteps: ["s8"]
        ),
        Organization(
            id: "fcc-exp",
            name: "FCC Experimentation & G-3/5/7",
            abbreviation: "FCC G-3/5/7",
            category: .experimentation,
            plainEnglishRole: "Plans and runs the FCC's experimentation campaigns and learning demands.",
            owns: ["Experimentation campaign planning", "Learning demand management"],
            doesNotOwn: ["Operational test", "Analysis (TDAC/CAA)"],
            keyRelationships: ["JMC", "FCDs", "TDAC", "Operational units"],
            typicalOutputs: ["Experimentation plans", "Learning results"],
            whenToInvolve: "When a concept or prototype needs to be learned about with Soldiers.",
            relatedProcessSteps: ["s6"]
        ),
        Organization(
            id: "c2fcd",
            name: "Command and Control (C2) Future Capability Directorate",
            abbreviation: "C2 FCD",
            category: .functional,
            plainEnglishRole: "One of FCC's nine FCDs. Drives command-and-control functional transformation by informing concepts, requirements, and experimentation, and owns the C2 functional problem and its capability gaps.",
            owns: ["C2 functional problem framing", "C2 capability gaps and learning demands"],
            doesNotOwn: ["Acquisition", "Resourcing", "C2 doctrine ownership (CAC/proponent)"],
            keyRelationships: ["FCC", "CAC TID", "DEVCOM C5ISR", "JMC", "TDAC", "FCC FID"],
            typicalOutputs: ["C2 functional modernization problems", "C2 capability gaps", "Concept-required capabilities"],
            whenToInvolve: "Whenever the operational problem is primarily about command and control.",
            relatedProcessSteps: ["s3", "s8"]
        ),
        Organization(
            id: "fcds",
            name: "Future Capability Directorates",
            abbreviation: "FCDs",
            category: .functional,
            plainEnglishRole: "The nine FCDs — Aviation, C2, Cyber, Fires, Formation Based Layered Protection (FBLP), Intelligence, Maneuver, Medical, and Sustainment — are subordinate to FCC and drive functional transformation by informing concepts, requirements, and experimentation. They combined the former CDIDs and cross-functional teams to improve unity of command and effort.",
            owns: ["Functional problem framing in their area", "Capability gaps and learning demands", "Informing concepts, requirements, and experimentation for their function"],
            doesNotOwn: ["Acquisition", "Resourcing", "Doctrine ownership"],
            keyRelationships: ["FCC", "CAC", "DEVCOM", "TDAC", "FCC FID"],
            typicalOutputs: ["Functional modernization problems", "Capability gaps"],
            whenToInvolve: "When the problem spans or belongs to another warfighting function.",
            relatedProcessSteps: ["s3", "s8"]
        ),
        Organization(
            id: "cac",
            name: "Combined Arms Command",
            abbreviation: "CAC",
            category: .combinedArms,
            plainEnglishRole: "A three-star subordinate command of T2COM at Fort Leavenworth (redesignated from the Combined Arms Center) and a peer of FCC. The Army's lead for leader development, doctrine, training, and combined-arms integration.",
            owns: ["Doctrine", "Training development", "Leader development", "DOTMLPF-P integration"],
            doesNotOwn: ["Future concepts (FCC)", "Acquisition", "Resourcing"],
            keyRelationships: ["T2COM (higher headquarters)", "FCC (peer command)", "Centers of Excellence", "Gaining units"],
            typicalOutputs: ["Doctrine", "Training products", "DOTMLPF-P assessments"],
            whenToInvolve: "Whenever non-materiel (doctrine, organization, training, leadership) change may be involved.",
            relatedProcessSteps: ["s4", "s12", "s13"]
        ),
        Organization(
            id: "cactid",
            name: "CAC Training and Integration Directorate",
            abbreviation: "CAC TID",
            category: .combinedArms,
            plainEnglishRole: "Integrates DOTMLPF-P implications across proponents and Centers of Excellence.",
            owns: ["DOTMLPF-P integration analysis", "Proponent coordination"],
            doesNotOwn: ["Materiel acquisition", "Requirements validation authority"],
            keyRelationships: ["CAC", "Centers of Excellence", "FCDs", "Proponents"],
            typicalOutputs: ["DOTMLPF-P implications", "Integration assessments"],
            whenToInvolve: "Early, to test whether the gap is materiel or non-materiel.",
            relatedProcessSteps: ["s4"]
        ),
        Organization(
            id: "coe",
            name: "Centers of Excellence / Proponents",
            abbreviation: "CoE",
            category: .combinedArms,
            plainEnglishRole: "Branch and functional experts who own doctrine, training, and proponency for their area.",
            owns: ["Branch doctrine and training", "Proponent requirements input"],
            doesNotOwn: ["Acquisition", "Resourcing", "Future concept authorship"],
            keyRelationships: ["CAC", "CAC TID", "FCDs"],
            typicalOutputs: ["Proponent input", "Branch doctrine and training"],
            whenToInvolve: "When branch- or function-specific expertise is needed for DOTMLPF-P.",
            relatedProcessSteps: ["s4", "s8"]
        ),
        Organization(
            id: "devcom",
            name: "Combat Capabilities Development Command",
            abbreviation: "DEVCOM",
            category: .scienceTech,
            plainEnglishRole: "A subordinate command of FCC and the Army's organic science, technology, and analysis organization. Accelerates research, development, engineering, and analysis to deliver warfighter capabilities, and provides the in-house scientific and engineering expertise behind continuous transformation.",
            owns: ["Science and technology", "Basic and applied research and lifecycle engineering", "Technical feasibility", "Prototyping"],
            doesNotOwn: ["Requirements validation", "Acquisition execution", "Resourcing"],
            keyRelationships: ["FCC (higher headquarters)", "ARL", "C5ISR Center", "FCDs", "ASA(ALT)", "Industry"],
            typicalOutputs: ["Technical feasibility assessments", "Prototypes", "S&T roadmaps"],
            whenToInvolve: "When you need to know whether a solution is technically possible or mature.",
            relatedProcessSteps: ["s5"]
        ),
        Organization(
            id: "arl",
            name: "Army Research Laboratory",
            abbreviation: "ARL",
            category: .scienceTech,
            plainEnglishRole: "The Army's foundational research laboratory (a DEVCOM element) focused on long-horizon science.",
            owns: ["Foundational research", "Scientific discovery"],
            doesNotOwn: ["Requirements", "Acquisition", "Fielding"],
            keyRelationships: ["DEVCOM", "Academia", "Industry"],
            typicalOutputs: ["Research findings", "Technology maturity insights"],
            whenToInvolve: "When the problem depends on emerging or not-yet-mature science.",
            relatedProcessSteps: ["s5"]
        ),
        Organization(
            id: "mrdc",
            name: "Medical Research and Development Command",
            abbreviation: "MRDC",
            category: .scienceTech,
            plainEnglishRole: "A subordinate command of FCC and the Army's medical materiel developer, responsible for medical research, development, and acquisition. Headquartered at Fort Detrick, MD, with eight subordinate commands worldwide.",
            owns: ["Medical research, development, and acquisition", "Medical materiel development"],
            doesNotOwn: ["Non-medical acquisition", "Requirements validation"],
            keyRelationships: ["FCC (higher headquarters)", "DEVCOM", "Medical FCD", "ASA(ALT)"],
            typicalOutputs: ["Medical feasibility assessments", "Medical prototypes"],
            whenToInvolve: "When the capability has a medical or health dimension.",
            relatedProcessSteps: ["s5"]
        ),
        Organization(
            id: "tdac",
            name: "Transformation Decision Analysis Center",
            abbreviation: "TDAC",
            category: .analysis,
            plainEnglishRole: "Operates under FCC within T2COM. Leads, conducts, and delivers relevant, credible, objective, and timely analysis in support of Army decision needs — including systems and formation effectiveness analyses that inform Army, Joint Force, and Office of the Secretary of War decisions.",
            owns: ["Systems and formation effectiveness analysis", "Operational modeling and simulation", "Authoritative Army systems performance data", "Scenario development", "Validated weaponeering methods"],
            doesNotOwn: ["Requirements authorship", "Acquisition", "Test execution"],
            keyRelationships: ["FCC (higher headquarters)", "FCDs", "CAA", "ATEC"],
            typicalOutputs: ["Analysis reports", "Modeling and simulation results", "Systems performance data", "Scenarios", "Risk assessments"],
            whenToInvolve: "When experimentation and data need to be turned into rigorous evidence.",
            relatedProcessSteps: ["s7"]
        ),
        Organization(
            id: "jmc",
            name: "Joint Modernization Command",
            abbreviation: "JMC",
            category: .experimentation,
            plainEnglishRole: "A subordinate command of FCC, headquartered at Fort Bliss, TX. Plans, prepares, and executes Joint Warfighting Assessments, Project Convergence, and other concept and capability assessments through a campaign of persistent experimentation — worldwide, multi-echelon, joint, and multinational.",
            owns: ["Experimentation execution", "Joint Warfighting Assessments", "Project Convergence", "Persistent experimentation campaign"],
            doesNotOwn: ["Operational test (ATEC)", "Requirements", "Acquisition"],
            keyRelationships: ["FCC (higher headquarters)", "FCDs", "Operational units", "Joint and multinational partners", "ASA(ALT)"],
            typicalOutputs: ["Experimentation results", "Objective analysis and recommendations", "Military utility insights"],
            whenToInvolve: "When concepts and prototypes need to be experimented with at scale.",
            relatedProcessSteps: ["s6"]
        ),
        Organization(
            id: "usaric",
            name: "75th U.S. Army Reserve Innovation Command",
            abbreviation: "75th USARIC",
            category: .experimentation,
            plainEnglishRole: "Fosters innovation within the Army Reserve and enables persistent experimentation in support of the Army transformation enterprise, helping build and refine requirements for DOTMLPF-P solutions. Blends civilian-acquired skills with functional military expertise.",
            owns: ["Army Reserve innovation", "Persistent experimentation support", "Civilian-military skill integration for capability assessment"],
            doesNotOwn: ["Requirements validation", "Acquisition"],
            keyRelationships: ["FCC", "JMC", "Operational units", "Industry and civilian partners"],
            typicalOutputs: ["Innovation insights", "Experimentation support", "DOTMLPF-P requirement refinements"],
            whenToInvolve: "When reserve-component skills or distributed innovation and experimentation can help assess new capabilities.",
            relatedProcessSteps: ["s6"]
        ),
        Organization(
            id: "g8fd",
            name: "HQDA G-8 Force Development",
            abbreviation: "HQDA G-8 FD",
            category: .requirements,
            plainEnglishRole: "Helps validate and integrate requirements and connects them to the Army Program.",
            owns: ["Requirements validation support", "Force development integration"],
            doesNotOwn: ["Concept authorship", "Acquisition execution"],
            keyRelationships: ["FCC FID", "HQDA G-8 PAE", "ASA(ALT)"],
            typicalOutputs: ["Validated requirements", "Force development integration products"],
            whenToInvolve: "Before formal requirements are finalized and as they enter resourcing.",
            relatedProcessSteps: ["s8", "s9"],
            statutoryBasis: "The Army Staff exists to assist the Secretary of the Army (10 U.S.C. §7031). Note the contrast: under 10 U.S.C. §7014(c)(1), acquisition itself is reserved to the Office of the Secretary — which is why G-8 shapes requirements and resourcing but does not execute acquisition."
        ),
        Organization(
            id: "g8pae",
            name: "HQDA G-8 Program Analysis and Evaluation",
            abbreviation: "HQDA G-8 PAE",
            category: .resourcing,
            plainEnglishRole: "Analyzes affordability and helps build and balance the Army Program.",
            owns: ["Program analysis and evaluation", "Affordability analysis"],
            doesNotOwn: ["Requirements authorship", "Acquisition execution"],
            keyRelationships: ["HQDA G-8 FD", "PEGs", "ASA(FM&C)"],
            typicalOutputs: ["Affordability analysis", "Program build inputs"],
            whenToInvolve: "When affordability and program trade-offs must be assessed.",
            relatedProcessSteps: ["s9"]
        ),
        Organization(
            id: "asaalt",
            name: "Assistant Secretary of the Army (Acquisition, Logistics & Technology)",
            abbreviation: "ASA(ALT)",
            category: .acquisition,
            plainEnglishRole: "The Army's acquisition executive; owns acquisition policy and oversight of programs.",
            owns: ["Acquisition policy", "Program oversight", "Acquisition strategy approval"],
            doesNotOwn: ["Requirements (FCC/G-8)", "Operational test (ATEC)"],
            keyRelationships: ["PAEs", "CPEs", "PEOs", "PMs", "HQDA G-8"],
            typicalOutputs: ["Acquisition policy", "Acquisition decisions"],
            whenToInvolve: "When the problem moves toward acquisition strategy and execution.",
            relatedProcessSteps: ["s10", "s13"],
            statutoryBasis: "10 U.S.C. §7016(b)(5): the ASA(ALT)'s principal duty is 'the overall supervision of acquisition, technology, and logistics matters of the Department of the Army.' Under 10 U.S.C. §7014(c)(1), the Office of the Secretary of the Army has sole responsibility for the acquisition function."
        ),
        Organization(
            id: "pae",
            name: "Portfolio Acquisition Executive",
            abbreviation: "PAE",
            category: .acquisition,
            plainEnglishRole: "Holds accountability for a portfolio of capabilities and balances trade-offs across it.",
            owns: ["Portfolio-level accountability", "Cross-program trade-offs", "Test integration within the portfolio"],
            doesNotOwn: ["Requirements generation", "Resourcing decisions"],
            keyRelationships: ["ASA(ALT)", "CPEs", "PEOs", "PMs", "ATEC"],
            typicalOutputs: ["Portfolio strategy", "Trade-off decisions"],
            whenToInvolve: "When capabilities must be balanced across a portfolio rather than program by program.",
            relatedProcessSteps: ["s10", "s11"]
        ),
        Organization(
            id: "cpe",
            name: "Capability Program Executive",
            abbreviation: "CPE",
            category: .acquisition,
            plainEnglishRole: "Leads execution of a specific capability program area within a portfolio.",
            owns: ["Capability program execution", "Program-area integration"],
            doesNotOwn: ["Requirements authorship", "Resourcing authority"],
            keyRelationships: ["PAE", "PEOs", "PMs"],
            typicalOutputs: ["Program execution plans", "Capability delivery"],
            whenToInvolve: "When a specific capability program needs execution leadership.",
            relatedProcessSteps: ["s10"]
        ),
        Organization(
            id: "peo",
            name: "Program Executive Office",
            abbreviation: "PEO",
            category: .acquisition,
            plainEnglishRole: "Executes a group of acquisition programs and supervises the PMs under it.",
            owns: ["Program execution", "PM supervision", "Acquisition delivery"],
            doesNotOwn: ["Requirements generation", "Resourcing decisions", "Operational test"],
            keyRelationships: ["ASA(ALT)", "PAE", "CPE", "PMs", "ATEC"],
            typicalOutputs: ["Acquisition programs", "Contracts", "Delivered systems"],
            whenToInvolve: "When programs are being executed and delivered.",
            relatedProcessSteps: ["s10", "s11"]
        ),
        Organization(
            id: "pm",
            name: "Product or Project Manager",
            abbreviation: "PM",
            category: .acquisition,
            plainEnglishRole: "Manages the cost, schedule, and performance of a specific program or product.",
            owns: ["Program cost, schedule, performance", "Contract execution"],
            doesNotOwn: ["Requirements generation", "Operational test", "Resourcing"],
            keyRelationships: ["PEO", "Contracting officials", "ATEC", "Gaining units"],
            typicalOutputs: ["Contracts", "Prototypes", "Production and fielding plans"],
            whenToInvolve: "When a specific product or system is being developed, contracted, or fielded.",
            relatedProcessSteps: ["s10", "s11", "s12"]
        ),
        Organization(
            id: "atec",
            name: "Army Test and Evaluation Command",
            abbreviation: "ATEC",
            category: .test,
            plainEnglishRole: "A Direct Reporting Unit reporting to the Chief of Staff of the Army, headquartered at Aberdeen Proving Ground. Plans, integrates, and conducts experiments, developmental testing, independent operational testing, and independent evaluations and assessments to inform acquisition decision-makers and commanders.",
            owns: ["Developmental and independent operational test", "Independent evaluation and assessment", "Safety releases"],
            doesNotOwn: ["Requirements", "Acquisition", "Resourcing"],
            keyRelationships: ["PEOs", "PMs", "PAE test integrators", "Operational units", "TDAC"],
            typicalOutputs: ["Test data", "Evaluation reports", "Safety releases"],
            whenToInvolve: "When a capability must be tested and independently evaluated before scaling.",
            relatedProcessSteps: ["s7", "s11"],
            statutoryBasis: "Independent test is statutory: under 10 U.S.C. §4171, covered major defense acquisition programs may not proceed beyond low-rate initial production until initial operational test and evaluation is complete; 10 U.S.C. §4172 requires survivability and lethality testing before full-scale production."
        ),
        Organization(
            id: "units",
            name: "Operational Units",
            abbreviation: "Units",
            category: .operational,
            plainEnglishRole: "The Soldiers and formations who experiment with, test, receive, employ, and give feedback on capabilities.",
            owns: ["Operational employment", "Soldier feedback", "Real-world learning"],
            doesNotOwn: ["Requirements authorship", "Acquisition", "Resourcing"],
            keyRelationships: ["JMC", "CTCs", "ATEC", "AMC", "FCC"],
            typicalOutputs: ["Soldier feedback", "Lessons learned", "Operational insights"],
            whenToInvolve: "Throughout — especially experimentation, test, fielding, and feedback.",
            relatedProcessSteps: ["s6", "s11", "s12", "s13"]
        ),
        Organization(
            id: "ascc",
            name: "Army Service Component Commands",
            abbreviation: "ASCCs",
            category: .operational,
            plainEnglishRole: "The Army's theater-level commands assigned to combatant commands — ARCYBER, ARTRANS, USARCENT, USAREUR-AF, USARPAC, USASMDC, USASOC, and USAWHC. They employ fielded capabilities in theater and are a key source of operational feedback.",
            owns: ["Army operations in their combatant command's area of responsibility", "Theater employment of fielded capabilities", "Operational feedback from theater"],
            doesNotOwn: ["Requirements", "Acquisition", "Resourcing"],
            keyRelationships: ["CCMDs", "HQDA", "AMC", "Gaining units", "FCC"],
            typicalOutputs: ["Theater operational feedback", "Employment insights", "Lessons learned"],
            whenToInvolve: "When fielding into a theater and when capturing operational feedback from employment.",
            relatedProcessSteps: ["s12", "s13"]
        ),
        Organization(
            id: "amc",
            name: "Army Materiel Command / Sustainment Enterprise",
            abbreviation: "AMC",
            category: .sustainment,
            plainEnglishRole: "An Army Command headquartered at Redstone Arsenal that provides superior technology, acquisition support, and logistics to ensure dominant land force capability — leading materiel readiness, fielding logistics, and lifecycle sustainment.",
            owns: ["Materiel readiness", "Fielding logistics", "Lifecycle sustainment"],
            doesNotOwn: ["Requirements", "Acquisition program decisions", "Operational test"],
            keyRelationships: ["ASC", "PEOs/PMs", "Gaining units", "CAC"],
            typicalOutputs: ["Fielding plans", "Sustainment plans", "Readiness support"],
            whenToInvolve: "When fielding, sustainment, and lifecycle support must be planned.",
            relatedProcessSteps: ["s12"]
        )
    ]

    // MARK: Responsibility matrix

    let matrixEntries: [MatrixEntry] = AppData.buildMatrix()

    // MARK: Glossary

    let glossary: [GlossaryTerm] = [
        GlossaryTerm(id: "dotmlpfp", term: "DOTMLPF-P", definition: "A checklist of the dimensions a capability solution can involve: Doctrine, Organization, Training, Materiel, Leadership & education, Personnel, Facilities, and Policy.", whyItMatters: "It forces you to ask whether a problem really needs new equipment, or whether changing how we train, organize, or operate would solve it faster and cheaper.", example: "The DOTMLPF-P review showed the gap was mostly a training and doctrine problem, not a materiel one."),
        GlossaryTerm(id: "cba", term: "CBA", definition: "Capabilities-Based Assessment — a structured study that identifies capability gaps, their causes, and possible solution approaches.", whyItMatters: "It is the analytical front end that justifies why a requirement is needed before anyone writes one.", example: "The CBA confirmed a real gap in long-range sensing before the team drafted a requirement."),
        GlossaryTerm(id: "tba", term: "TBA", definition: "TRADOC-Based Assessment (or task-based assessment) — a TRADOC-led analysis of capability needs and gaps.", whyItMatters: "It provides Army/TRADOC analytical grounding for capability decisions.", example: "Findings from the TBA shaped how the FCD framed the functional problem."),
        GlossaryTerm(id: "icd", term: "ICD", definition: "Initial Capabilities Document — describes a capability gap and the need for a materiel or non-materiel solution.", whyItMatters: "It is often the first formal requirements artifact that opens the door to materiel development.", example: "The ICD documented the gap and recommended pursuing a materiel solution."),
        GlossaryTerm(id: "cdd", term: "CDD", definition: "Capability Development Document — specifies the performance attributes a system must meet.", whyItMatters: "It is the detailed requirement a program is held accountable to deliver.", example: "The CDD set the key performance parameters the PM had to satisfy."),
        GlossaryTerm(id: "acdd", term: "A-CDD", definition: "Abbreviated Capability Development Document — a streamlined CDD used for faster or smaller efforts.", whyItMatters: "It supports speed by reducing requirements overhead when the situation allows.", example: "Because the effort was urgent, the team used an A-CDD instead of a full CDD."),
        GlossaryTerm(id: "conops", term: "CONOPS", definition: "Concept of Operations — a plain-language description of how a capability will be employed operationally.", whyItMatters: "It connects the requirement to how Soldiers will actually use the capability.", example: "The CONOPS clarified how the new sensor would feed the fires kill chain."),
        GlossaryTerm(id: "fcw", term: "FCW", definition: "Future Warfighting Concept — describes how the future Army intends to fight.", whyItMatters: "It anchors modernization to a shared vision of future warfare.", example: "Each capability gap was traced back to the FCW."),
        GlossaryTerm(id: "fdw", term: "FDW", definition: "Future Deep Warfare / future-focused warfighting concept area — a forward-looking concept element (terminology varies by guidance).", whyItMatters: "It helps frame specialized future-fight problems within the broader concept.", example: "The FDW work informed how the FCD scoped the deep-fight problem."),
        GlossaryTerm(id: "fdu", term: "FDU", definition: "Force Design Update — a proposed change to how a formation is organized.", whyItMatters: "It is the mechanism for non-materiel organizational change.", example: "The team pursued an FDU to reorganize the unit rather than buy new equipment."),
        GlossaryTerm(id: "jcids", term: "JCIDS", definition: "Joint Capabilities Integration and Development System — the Joint process for identifying and validating capability requirements.", whyItMatters: "It governs how Joint requirements are validated and is relevant when a need is Joint.", example: "Because the need was Joint, the requirement went through JCIDS.", statutoryBasis: "Implements the JROC's authorities under 10 U.S.C. §181; process details are set by CJCS policy and evolve with current guidance."),
        GlossaryTerm(id: "jfrp", term: "JFRP", definition: "Joint Force Requirements Process (an evolving streamlined approach to Joint requirements; terminology depends on current guidance).", whyItMatters: "It reflects efforts to make Joint requirements faster and more relevant.", example: "The team tracked JFRP changes to understand the Joint validation path."),
        GlossaryTerm(id: "jroc", term: "JROC", definition: "Joint Requirements Oversight Council — the senior Joint body, chaired by the Vice Chairman of the Joint Chiefs of Staff, that validates major requirements.", whyItMatters: "It is the Joint decision authority for significant capability requirements — and its statutory mission now centers on joint operational problems, not documents.", example: "The major requirement required JROC validation.", statutoryBasis: "10 U.S.C. §181. The JROC's statutory mission includes compiling, refining, and prioritizing joint operational problems; recommending nonprescriptive solutions to them; maintaining a repository of joint operational problems; and identifying commercial solutions and concepts that improve the joint force's military advantage."),
        GlossaryTerm(id: "ppbe", term: "PPBE", definition: "Planning, Programming, Budgeting, and Execution — the DoD process for building and managing budgets.", whyItMatters: "It determines whether and when a capability actually gets funded.", example: "Even a validated requirement waits on the PPBE cycle for funding."),
        GlossaryTerm(id: "peg", term: "PEG", definition: "Program Evaluation Group — Army bodies that build and balance portions of the Army Program by function.", whyItMatters: "PEGs are where resourcing trade-offs get made.", example: "The capability had to compete for funding within its PEG."),
        GlossaryTerm(id: "pom", term: "POM", definition: "Program Objective Memorandum — the Army's multi-year program and funding proposal.", whyItMatters: "If a capability is not in the POM, it is generally not funded.", example: "The team worked to get the capability into the next POM."),
        GlossaryTerm(id: "fydp", term: "FYDP", definition: "Future Years Defense Program — the multi-year projection of DoD programs and funding.", whyItMatters: "It shows whether a capability is affordable across the planning horizon.", example: "The affordability analysis checked how the program fit within the FYDP."),
        GlossaryTerm(id: "asarc", term: "ASARC", definition: "Army Systems Acquisition Review Council — a senior Army acquisition decision forum.", whyItMatters: "It is a key oversight body for major Army acquisition decisions.", example: "The program prepared for its ASARC milestone review."),
        GlossaryTerm(id: "mta", term: "MTA", definition: "Middle Tier of Acquisition — statutory pathways for rapid prototyping and rapid fielding, for programs intended to be completed within two to five years.", whyItMatters: "It lets the Army move faster than the traditional acquisition pathway when appropriate.", example: "The team used the MTA rapid-prototyping pathway to move quickly.", statutoryBasis: "10 U.S.C. §3602 — directs establishment of two middle-tier pathways (rapid prototyping and rapid fielding) for programs intended to be completed in two to five years."),
        GlossaryTerm(id: "swp", term: "Software Acquisition Pathway", definition: "A statutory acquisition pathway designed for the continuous, iterative delivery of software.", whyItMatters: "Software needs frequent updates; this pathway fits that reality better than hardware-style milestones.", example: "Because the capability was software-centric, the PM used the Software Acquisition Pathway.", statutoryBasis: "10 U.S.C. §3603 — directs the Secretary of Defense to establish software acquisition pathways for efficient and effective acquisition, development, integration, and timely delivery of software."),
        GlossaryTerm(id: "pae", term: "PAE", definition: "Portfolio Acquisition Executive — accountable for a portfolio of capabilities and trade-offs across it.", whyItMatters: "It introduces portfolio-level accountability alongside individual program execution.", example: "The PAE balanced investment across the portfolio rather than program by program."),
        GlossaryTerm(id: "cpe", term: "CPE", definition: "Capability Program Executive — leads execution of a specific capability program area within a portfolio.", whyItMatters: "It provides focused execution leadership under the portfolio.", example: "The CPE drove execution of the capability program."),
        GlossaryTerm(id: "peo", term: "PEO", definition: "Program Executive Office — executes a group of acquisition programs and supervises PMs.", whyItMatters: "It is where acquisition delivery is managed day to day.", example: "The PEO oversaw several PMs delivering related systems."),
        GlossaryTerm(id: "pm", term: "PM", definition: "Product or Project Manager — owns cost, schedule, and performance of a program or product.", whyItMatters: "The PM is who actually delivers the system.", example: "The PM was accountable for delivering on cost and schedule."),
        GlossaryTerm(id: "atec", term: "ATEC", definition: "Army Test and Evaluation Command — independently tests and evaluates capabilities.", whyItMatters: "Independent test protects Soldiers and decision-makers from unvalidated claims.", example: "ATEC's independent evaluation informed the fielding decision.", statutoryBasis: "10 U.S.C. §4171 conditions proceeding beyond low-rate initial production on completed initial operational test and evaluation; §4172 requires survivability and lethality testing before full-scale production."),
        GlossaryTerm(id: "tdac", term: "TDAC", definition: "Transformation Decision Analysis Center — delivers objective, timely analysis (systems and formation effectiveness, modeling and simulation, scenarios) to inform Army decisions; operates under FCC.", whyItMatters: "It turns observations and data into rigorous, defensible evidence.", example: "TDAC's analysis showed the formation effect the capability would produce."),
        GlossaryTerm(id: "fcd", term: "FCD", definition: "Future Capability Directorate — one of nine FCC directorates (Aviation, C2, Cyber, Fires, FBLP, Intelligence, Maneuver, Medical, Sustainment) that drive functional transformation by informing concepts, requirements, and experimentation. Formed from the former CDIDs and cross-functional teams.", whyItMatters: "FCDs are where functional capability problems get owned and framed.", example: "The C2 FCD owned the command-and-control problem."),
        GlossaryTerm(id: "t2com", term: "T2COM", definition: "Transformation and Training Command — an Army Command headquartered in Austin, TX, established in 2025 by consolidating Army Futures Command and TRADOC. Integrates and synchronizes force generation, force development, and force design; higher headquarters of FCC.", whyItMatters: "It connects concepts, doctrine, training, and transformation under one command.", example: "T2COM helped frame the future-force context."),

        GlossaryTerm(id: "ascc", term: "ASCC", definition: "Army Service Component Command — the Army's theater-level command assigned to a combatant command (the eight ASCCs: ARCYBER, ARTRANS, USARCENT, USAREUR-AF, USARPAC, USASMDC, USASOC, USAWHC).", whyItMatters: "ASCCs are where fielded capabilities are employed in theater and where much operational feedback originates.", example: "The ASCC's theater feedback shaped the next iteration of the capability."),
        GlossaryTerm(id: "fcc", term: "FCC", definition: "Futures and Concepts Command — designs the future force through four core functions (concepts, experimentation, requirements, integration), subordinate to T2COM.", whyItMatters: "It is the front of the capability-development ecosystem, aimed at the Army needed 5 to 15 years out.", example: "The FCC framed the operational problem before requirements work began."),
        GlossaryTerm(id: "cactid", term: "CAC TID", definition: "CAC Training and Integration Directorate — integrates DOTMLPF-P implications across proponents.", whyItMatters: "It keeps non-materiel solutions and integration from being overlooked.", example: "CAC TID flagged the training and doctrine implications early."),
        GlossaryTerm(id: "devcom", term: "DEVCOM", definition: "Combat Capabilities Development Command — the Army's primary science and technology organization.", whyItMatters: "It tells you whether a solution is technically feasible and mature.", example: "DEVCOM assessed feasibility and built an early prototype."),
        GlossaryTerm(id: "arl", term: "ARL", definition: "Army Research Laboratory — the Army's foundational research lab and a DEVCOM element.", whyItMatters: "It addresses the long-horizon science behind future capabilities.", example: "ARL's research underpinned the emerging technology."),
        GlossaryTerm(id: "jmc", term: "JMC", definition: "Joint Modernization Command — a subordinate command of FCC at Fort Bliss that plans and executes Joint Warfighting Assessments, Project Convergence, and persistent experimentation.", whyItMatters: "It is where concepts and prototypes meet Soldiers at scale.", example: "JMC ran the experiment that tested the new concept.")
    ]

    // MARK: Quiz questions

    let quizQuestions: [QuizQuestion] = [
        QuizQuestion(id: "q1", category: "Who first?", prompt: "A new operational problem about command and control has just been identified. Who should generally own and frame the functional problem first?", options: ["A PEO", "The C2 FCD", "ATEC", "A contracting officer"], correctIndex: 1, explanation: "Functional problem ownership typically sits with the relevant Future Capability Directorate — here, the C2 FCD — before acquisition or test organizations engage."),
        QuizQuestion(id: "q2", category: "Materiel vs DOTMLPF-P", prompt: "A unit says it 'needs a new app' but the real issue is that no doctrine or training exists for a task. What does this most likely indicate?", options: ["A pure materiel gap", "A DOTMLPF-P (non-materiel) gap", "A resourcing decision", "A test failure"], correctIndex: 1, explanation: "Many 'materiel' requests are actually DOTMLPF-P gaps. CAC / CAC TID help determine whether doctrine, training, or organization changes solve the problem."),
        QuizQuestion(id: "q3", category: "Analysis", prompt: "Which organization most typically provides operational analysis and modeling and simulation to turn experimentation into evidence?", options: ["TDAC", "PEO", "AMC", "CPE"], correctIndex: 0, explanation: "TDAC (with CAA and ORSAs) provides the operational analysis and modeling and simulation that generate evidence."),
        QuizQuestion(id: "q4", category: "Acquisition", prompt: "Which organization owns acquisition execution and program delivery?", options: ["FCC", "TDAC", "PEO / PM under ASA(ALT)", "CAC"], correctIndex: 2, explanation: "Acquisition execution belongs to ASA(ALT) and its PEOs/PMs (with PAEs/CPEs for portfolio accountability) — not to the FCC or CAC."),
        QuizQuestion(id: "q5", category: "Resourcing", prompt: "Where does HQDA G-8 most clearly enter the process?", options: ["Writing concepts", "Resourcing and prioritization (and helping validate requirements)", "Running experiments", "Operational test"], correctIndex: 1, explanation: "HQDA G-8 is central to resourcing and prioritization, and G-8 Force Development helps validate and integrate requirements."),
        QuizQuestion(id: "q6", category: "Roles", prompt: "What is the key difference between FCC/FCDs and PEOs/PMs?", options: ["They are the same organization", "FCC/FCDs frame problems and requirements; PEOs/PMs execute acquisition and deliver", "FCC/FCDs run operational test", "PEOs/PMs write the concepts"], correctIndex: 1, explanation: "FCC/FCDs frame operational problems and requirements; PEOs/PMs (under ASA(ALT)) execute acquisition and deliver systems. The new model does not merge these roles."),
        QuizQuestion(id: "q7", category: "Experimentation", prompt: "Soldiers need to try a prototype at scale to see if a concept works. Which organization most typically plans and runs that experimentation?", options: ["JMC", "ARL", "ASA(FM&C)", "ASARC"], correctIndex: 0, explanation: "JMC plans and executes large-scale experimentation (including Project Convergence), putting concepts and prototypes in front of Soldiers."),
        QuizQuestion(id: "q8", category: "S&T", prompt: "You need to know whether a proposed solution is even technically possible. Who do you engage?", options: ["DEVCOM", "G-8 PAE", "ATEC", "AMC"], correctIndex: 0, explanation: "DEVCOM (with ARL, MRDC, and the C5ISR Center) assesses technical feasibility and technology maturity."),
        QuizQuestion(id: "q9", category: "Test", prompt: "Who independently tests and evaluates a capability for effectiveness, suitability, and safety before scaling?", options: ["FCC FID", "ATEC", "DoC", "PEG"], correctIndex: 1, explanation: "ATEC independently tests and evaluates capabilities and issues safety releases."),
        QuizQuestion(id: "q10", category: "Process shape", prompt: "How is Army capability development best understood in the emerging model?", options: ["A strictly linear requirements-to-program pipeline", "An iterative operational problem → portfolio → evidence loop", "A single document handed from one office to the next", "Entirely owned by ASA(ALT)"], correctIndex: 1, explanation: "It is best understood as an iterative, distributed loop — operational problem to portfolio to evidence — with feedback, not a linear pipeline."),
        QuizQuestion(id: "q11", category: "Requirements", prompt: "When translating evidence into a formal requirement, what is the disciplined goal?", options: ["Capture every desirable feature", "Write the minimum viable requirement the evidence justifies", "Skip requirements entirely", "Let the PM define the requirement"], correctIndex: 1, explanation: "The discipline is to write the minimum viable requirement justified by evidence — avoiding gold-plating that no pathway can deliver."),
        QuizQuestion(id: "q12", category: "Fielding", prompt: "Before declaring a capability 'fielded,' what must be true of the gaining units?", options: ["Nothing beyond delivery", "They can absorb, train, maintain, and employ it", "Only that the contract closed", "Only that ATEC tested it"], correctIndex: 1, explanation: "Fielding includes formation integration: units must be able to absorb, train, maintain, and employ the capability, with sustainment planned.")
    ]

    // MARK: Helpers

    func step(id: String) -> ProcessStep? { processSteps.first { $0.id == id } }
    func organization(id: String) -> Organization? { organizations.first { $0.id == id } }
    func glossaryTerm(id: String) -> GlossaryTerm? { glossary.first { $0.id == id } }

    func organizations(for function: ProcessFunction) -> [(Organization, ResponsibilityLevel)] {
        matrixEntries
            .filter { $0.function == function }
            .compactMap { entry in
                guard let org = organization(id: entry.organizationId) else { return nil }
                return (org, entry.responsibilityLevel)
            }
            .sorted { lhs, rhs in
                let order: [ResponsibilityLevel] = [.lead, .support, .inform, .receive]
                return order.firstIndex(of: lhs.1)! < order.firstIndex(of: rhs.1)!
            }
    }

    func entry(orgId: String, function: ProcessFunction) -> MatrixEntry? {
        matrixEntries.first { $0.organizationId == orgId && $0.function == function }
    }

    /// Try to resolve a process step's free-text organization label to a real
    /// Organization for deep linking.
    func resolveOrganization(label: String) -> Organization? {
        let lower = label.lowercased()
        return organizations.first { org in
            org.abbreviation.lowercased() == lower || org.name.lowercased() == lower
        } ?? organizations.first { org in
            lower.contains(org.abbreviation.lowercased()) || org.name.lowercased().contains(lower)
        }
    }
}

// MARK: - Matrix data

extension AppData {
    /// Builds the responsibility matrix. Organized by organization for easy editing.
    static func buildMatrix() -> [MatrixEntry] {
        // Compact helper: (orgId, [(function, level)])
        let data: [(String, [(ProcessFunction, ResponsibilityLevel)])] = [
            ("fcc", [(.concepts, .lead), (.experimentation, .lead), (.requirements, .lead), (.analysis, .support), (.feedback, .lead), (.dotmlpfp, .support)]),
            ("doc", [(.concepts, .lead), (.requirements, .inform)]),
            ("fid", [(.requirements, .lead), (.concepts, .support), (.analysis, .receive)]),
            ("fcc-exp", [(.experimentation, .lead), (.concepts, .support), (.analysis, .inform)]),
            ("c2fcd", [(.concepts, .support), (.requirements, .lead), (.experimentation, .support), (.dotmlpfp, .support), (.feedback, .support)]),
            ("fcds", [(.concepts, .support), (.requirements, .lead), (.experimentation, .support), (.dotmlpfp, .support)]),
            ("cac", [(.dotmlpfp, .lead), (.fielding, .support), (.feedback, .support), (.concepts, .inform)]),
            ("cactid", [(.dotmlpfp, .lead), (.requirements, .support)]),
            ("coe", [(.dotmlpfp, .support), (.requirements, .inform)]),
            ("devcom", [(.scienceTech, .lead), (.experimentation, .support), (.requirements, .inform)]),
            ("arl", [(.scienceTech, .support)]),
            ("mrdc", [(.scienceTech, .support)]),
            ("tdac", [(.analysis, .lead), (.experimentation, .support), (.requirements, .inform)]),
            ("jmc", [(.experimentation, .lead), (.analysis, .support), (.feedback, .support)]),
            ("usaric", [(.experimentation, .support), (.feedback, .inform)]),
            ("g8fd", [(.requirements, .support), (.resourcing, .support)]),
            ("g8pae", [(.resourcing, .lead)]),
            ("asaalt", [(.acquisition, .lead), (.testing, .inform), (.feedback, .receive)]),
            ("pae", [(.acquisition, .lead), (.testing, .support), (.resourcing, .inform)]),
            ("cpe", [(.acquisition, .support)]),
            ("peo", [(.acquisition, .support), (.testing, .support), (.fielding, .support)]),
            ("pm", [(.acquisition, .support), (.testing, .support), (.fielding, .lead)]),
            ("atec", [(.testing, .lead), (.analysis, .support)]),
            ("units", [(.experimentation, .support), (.testing, .support), (.fielding, .receive), (.feedback, .lead)]),
            ("ascc", [(.fielding, .receive), (.feedback, .support)]),
            ("amc", [(.fielding, .lead), (.feedback, .inform)])
        ]
        return data.flatMap { orgId, pairs in
            pairs.map { MatrixEntry(organizationId: orgId, function: $0.0, responsibilityLevel: $0.1) }
        }
    }
}

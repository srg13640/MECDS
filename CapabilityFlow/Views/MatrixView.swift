import SwiftUI

struct MatrixView: View {
    private let data = AppData.shared
    @State private var selectedFunction: ProcessFunction? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                CardContainer {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Who Does What").font(.headline)
                        Text("Responsibility by function. Tap a function to focus. Roles are typical and depend on authority and guidance.")
                            .font(.caption).foregroundStyle(.secondary)
                        legend
                    }
                }

                // Function filter.
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "All functions", isSelected: selectedFunction == nil) { selectedFunction = nil }
                        ForEach(ProcessFunction.allCases) { fn in
                            FilterChip(title: fn.rawValue, isSelected: selectedFunction == fn) {
                                selectedFunction = (selectedFunction == fn) ? nil : fn
                            }
                        }
                    }
                }

                if let fn = selectedFunction {
                    focusedView(fn)
                } else {
                    fullGrid
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Matrix")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var legend: some View {
        HStack(spacing: 10) {
            ForEach(ResponsibilityLevel.allCases) { level in
                HStack(spacing: 4) {
                    Text(level.indicator)
                        .font(.caption2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 18, height: 18)
                        .background(Theme.responsibilityColor(level), in: RoundedRectangle(cornerRadius: 4))
                    Text(level.rawValue).font(.caption2).foregroundStyle(.secondary)
                }
            }
        }
        .padding(.top, 4)
    }

    // MARK: Focused view for one function

    private func focusedView(_ fn: ProcessFunction) -> some View {
        let rows = data.organizations(for: fn)
        return CardContainer {
            VStack(alignment: .leading, spacing: 12) {
                Text(fn.rawValue).font(.title3.bold())
                if rows.isEmpty {
                    Text("No organizations mapped to this function yet.")
                        .font(.subheadline).foregroundStyle(.secondary)
                }
                ForEach(rows, id: \.0.id) { org, level in
                    NavigationLink(value: org) {
                        HStack(spacing: 12) {
                            Text(level.indicator)
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                                .frame(width: 26, height: 26)
                                .background(Theme.responsibilityColor(level), in: RoundedRectangle(cornerRadius: 6))
                            VStack(alignment: .leading, spacing: 2) {
                                Text(org.abbreviation).font(.subheadline.weight(.semibold)).foregroundStyle(.primary)
                                Text(level.rawValue).font(.caption2).foregroundStyle(Theme.responsibilityColor(level))
                            }
                            Spacer()
                            Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary)
                        }
                        .padding(.vertical, 2)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: Full grid (organizations x functions)

    private var fullGrid: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                // Header row.
                HStack(spacing: 0) {
                    Text("Org")
                        .font(.caption2.bold())
                        .frame(width: 92, alignment: .leading)
                        .padding(.vertical, 8)
                    ForEach(ProcessFunction.allCases) { fn in
                        Text(short(fn))
                            .font(.system(size: 9, weight: .semibold))
                            .frame(width: 38)
                            .padding(.vertical, 8)
                    }
                }
                .background(Color(.tertiarySystemFill))

                ForEach(data.organizations) { org in
                    HStack(spacing: 0) {
                        Text(org.abbreviation)
                            .font(.caption2.weight(.medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .frame(width: 92, alignment: .leading)
                            .padding(.vertical, 6)
                        ForEach(ProcessFunction.allCases) { fn in
                            cell(orgId: org.id, fn: fn)
                                .frame(width: 38)
                                .padding(.vertical, 6)
                        }
                    }
                    Divider()
                }
            }
            .padding(8)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private func cell(orgId: String, fn: ProcessFunction) -> some View {
        Group {
            if let entry = data.entry(orgId: orgId, function: fn) {
                Text(entry.responsibilityLevel.indicator)
                    .font(.caption2.bold())
                    .foregroundStyle(.white)
                    .frame(width: 22, height: 22)
                    .background(Theme.responsibilityColor(entry.responsibilityLevel), in: RoundedRectangle(cornerRadius: 5))
            } else {
                Text("·").foregroundStyle(.tertiary)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func short(_ fn: ProcessFunction) -> String {
        switch fn {
        case .concepts: return "Conc"
        case .dotmlpfp: return "DOTM"
        case .experimentation: return "Exp"
        case .scienceTech: return "S&T"
        case .analysis: return "Anly"
        case .requirements: return "Reqs"
        case .resourcing: return "Resc"
        case .acquisition: return "Acq"
        case .testing: return "Test"
        case .fielding: return "Fld"
        case .feedback: return "Fdbk"
        }
    }
}

#Preview {
    NavigationStack { MatrixView() }
}

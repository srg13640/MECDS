import SwiftUI

/// Central place for the professional, muted "Army staff" aesthetic.
/// Colors adapt automatically to light and dark mode via system semantics
/// plus a small muted palette.
enum Theme {
    // Muted, professional palette.
    static let primary = Color("BrandPrimary")      // muted slate/olive (asset)
    static let accent = Color("AccentColor")

    static func responsibilityColor(_ level: ResponsibilityLevel) -> Color {
        switch level {
        case .lead: return Color(red: 0.20, green: 0.36, blue: 0.30)      // deep muted green
        case .support: return Color(red: 0.27, green: 0.40, blue: 0.50)   // muted blue
        case .inform: return Color(red: 0.55, green: 0.50, blue: 0.30)    // muted gold
        case .receive: return Color(red: 0.45, green: 0.45, blue: 0.48)   // gray
        }
    }

    static func categoryColor(_ category: OrgCategory) -> Color {
        switch category {
        case .concepts: return Color(red: 0.27, green: 0.40, blue: 0.50)
        case .functional: return Color(red: 0.30, green: 0.42, blue: 0.45)
        case .combinedArms: return Color(red: 0.40, green: 0.42, blue: 0.30)
        case .scienceTech: return Color(red: 0.35, green: 0.30, blue: 0.45)
        case .experimentation: return Color(red: 0.20, green: 0.45, blue: 0.45)
        case .analysis: return Color(red: 0.45, green: 0.35, blue: 0.30)
        case .requirements: return Color(red: 0.25, green: 0.38, blue: 0.48)
        case .resourcing: return Color(red: 0.45, green: 0.40, blue: 0.25)
        case .acquisition: return Color(red: 0.40, green: 0.28, blue: 0.32)
        case .test: return Color(red: 0.30, green: 0.40, blue: 0.35)
        case .sustainment: return Color(red: 0.35, green: 0.38, blue: 0.42)
        case .operational: return Color(red: 0.20, green: 0.36, blue: 0.30)
        }
    }
}

/// A reusable card container with the app's standard styling.
struct CardContainer<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(Color(.separator).opacity(0.4), lineWidth: 0.5)
            )
    }
}

/// A small colored pill/badge.
struct Badge: View {
    let text: String
    var color: Color = .secondary

    var body: some View {
        Text(text)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15), in: Capsule())
            .foregroundStyle(color)
    }
}

/// A labeled bullet section used across detail screens.
struct BulletSection: View {
    let title: String
    let items: [String]
    var systemImage: String? = nil

    var body: some View {
        if !items.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    if let systemImage {
                        Image(systemName: systemImage).foregroundStyle(Theme.accent)
                    }
                    Text(title).font(.headline)
                }

                ForEach(items, id: \.self) { item in
                    HStack(alignment: .top, spacing: 8) {
                        Text("•").foregroundStyle(Theme.accent)
                        Text(item).font(.subheadline).foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

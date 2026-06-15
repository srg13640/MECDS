import SwiftUI

/// A simple wrapping layout (like a flow / tag cloud) built on the Layout
/// protocol. Lays children left-to-right, wrapping to new lines as needed.
struct FlexibleWrap<Data: RandomAccessCollection, Content: View>: View
    where Data.Element: Hashable {

    let items: Data
    let spacing: CGFloat
    @ViewBuilder let content: (Data.Element) -> Content

    init(items: Data, spacing: CGFloat = 8, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        WrapLayout(spacing: spacing) {
            ForEach(Array(items), id: \.self) { item in
                content(item)
            }
        }
    }
}

private struct WrapLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
        // Fall back to a sensible width when unconstrained so we never collapse to 0.
        let maxWidth: CGFloat = {
            if let w = proposal.width, w > 0, w != .infinity { return w }
            return totalIntrinsicWidth(subviews: subviews)
        }()
        let rows = computeRows(maxWidth: maxWidth, subviews: subviews)
        let height = rows.reduce(CGFloat.zero) { $0 + $1.height + spacing } - (rows.isEmpty ? 0 : spacing)
        return CGSize(width: maxWidth, height: max(0, height))
    }

    private func totalIntrinsicWidth(subviews: Subviews) -> CGFloat {
        subviews.reduce(CGFloat.zero) { $0 + $1.sizeThatFits(.unspecified).width + spacing }
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
        let maxWidth = bounds.width
        let rows = computeRows(maxWidth: maxWidth, subviews: subviews)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            for index in row.indices {
                let size = subviews[index].sizeThatFits(.unspecified)
                subviews[index].place(at: CGPoint(x: x, y: y), anchor: .topLeading, proposal: ProposedViewSize(size))
                x += size.width + spacing
            }
            y += row.height + spacing
        }
    }

    private struct Row { var indices: [Int] = []; var height: CGFloat = 0 }

    private func computeRows(maxWidth: CGFloat, subviews: Subviews) -> [Row] {
        var rows: [Row] = []
        var current = Row()
        var x: CGFloat = 0
        for index in subviews.indices {
            let size = subviews[index].sizeThatFits(.unspecified)
            if x + size.width > maxWidth, !current.indices.isEmpty {
                rows.append(current)
                current = Row()
                x = 0
            }
            current.indices.append(index)
            current.height = max(current.height, size.height)
            x += size.width + spacing
        }
        if !current.indices.isEmpty { rows.append(current) }
        return rows
    }
}

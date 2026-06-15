import SwiftUI

struct QuizView: View {
    private let questions = AppData.shared.quizQuestions

    @State private var index = 0
    @State private var selected: Int? = nil
    @State private var answered = false
    @State private var score = 0
    @State private var finished = false

    var body: some View {
        Group {
            if finished {
                resultView
            } else {
                quizBody
            }
        }
        .navigationTitle("Training Quiz")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var current: QuizQuestion { questions[index] }

    private var quizBody: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                // Progress.
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Badge(text: current.category, color: Theme.accent)
                        Spacer()
                        Text("Question \(index + 1) of \(questions.count)")
                            .font(.caption).foregroundStyle(.secondary)
                    }
                    ProgressView(value: Double(index), total: Double(questions.count))
                        .tint(Theme.accent)
                }

                Text(current.prompt)
                    .font(.title3.weight(.semibold))
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 10) {
                    ForEach(Array(current.options.enumerated()), id: \.offset) { i, option in
                        optionButton(i, option)
                    }
                }

                if answered {
                    feedback
                    Button {
                        advance()
                    } label: {
                        Text(index == questions.count - 1 ? "See results" : "Next question")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(20)
        }
        .background(Color(.systemGroupedBackground))
    }

    private func optionButton(_ i: Int, _ option: String) -> some View {
        Button {
            guard !answered else { return }
            selected = i
            answered = true
            if i == current.correctIndex { score += 1 }
        } label: {
            HStack {
                Text(option).font(.subheadline).foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                Spacer()
                if answered {
                    if i == current.correctIndex {
                        Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                    } else if i == selected {
                        Image(systemName: "xmark.circle.fill").foregroundStyle(.red)
                    }
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(optionBackground(i), in: RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(optionBorder(i), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .disabled(answered)
    }

    private func optionBackground(_ i: Int) -> Color {
        guard answered else { return Color(.secondarySystemGroupedBackground) }
        if i == current.correctIndex { return Color.green.opacity(0.12) }
        if i == selected { return Color.red.opacity(0.12) }
        return Color(.secondarySystemGroupedBackground)
    }

    private func optionBorder(_ i: Int) -> Color {
        guard answered else { return Color(.separator).opacity(0.4) }
        if i == current.correctIndex { return .green }
        if i == selected { return .red }
        return Color(.separator).opacity(0.4)
    }

    private var feedback: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 6) {
                Label(selected == current.correctIndex ? "Correct" : "Not quite",
                      systemImage: selected == current.correctIndex ? "checkmark.seal" : "info.circle")
                    .font(.headline)
                    .foregroundStyle(selected == current.correctIndex ? .green : .orange)
                Text(current.explanation)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func advance() {
        if index == questions.count - 1 {
            finished = true
        } else {
            index += 1
            selected = nil
            answered = false
        }
    }

    private var resultView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 60))
                .foregroundStyle(Theme.accent)
            Text("You scored \(score) of \(questions.count)")
                .font(.title2.bold())
            Text(scoreMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button {
                index = 0; selected = nil; answered = false; score = 0; finished = false
            } label: {
                Label("Try again", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity).fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }

    private var scoreMessage: String {
        let ratio = Double(score) / Double(questions.count)
        switch ratio {
        case 0.9...: return "Excellent — you have a strong grasp of the ecosystem."
        case 0.7..<0.9: return "Solid. Review the steps you missed and try again."
        default: return "Good start. Explore the Process and Organizations screens, then retry."
        }
    }
}

#Preview {
    NavigationStack { QuizView() }
}

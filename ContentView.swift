import SwiftUI

struct ContentView: View {
    @StateObject private var quiz = QuizViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                HStack {
                    Text("Aptitude Quiz")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    Text("\(quiz.currentIndex + 1)/\(quiz.questions.count)")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }

                ProgressView(value: quiz.progress)
                    .tint(.blue)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(quiz.currentQuestion.question)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top, 10)

                        ForEach(Array(quiz.currentQuestion.options.enumerated()), id: \.offset) { index, option in
                            Button {
                                quiz.selectAnswer(index)
                            } label: {
                                HStack {
                                    Text(option)
                                        .font(.body)
                                        .foregroundStyle(.primary)

                                    Spacer()

                                    if let selected = quiz.selectedAnswer {
                                        if index == quiz.currentQuestion.correctAnswer {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.green)
                                        } else if index == selected {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundStyle(.red)
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(optionBackground(for: index))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.gray.opacity(0.3))
                                )
                            }
                            .disabled(quiz.selectedAnswer != nil)
                        }
                    }
                }

                HStack(spacing: 12) {
                    Button("Previous") {
                        quiz.previousQuestion()
                    }
                    .buttonStyle(.bordered)
                    .disabled(quiz.currentIndex == 0)

                    Spacer()

                    Button(quiz.currentIndex == quiz.questions.count - 1 ? "Finish" : "Next") {
                        quiz.nextQuestion()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(quiz.selectedAnswer == nil)
                }
            }
            .padding()
            .sheet(isPresented: $quiz.showResult) {
                ResultView(score: quiz.score, total: quiz.questions.count) {
                    quiz.restart()
                }
            }
        }
    }

    private func optionBackground(for index: Int) -> Color {
        guard let selected = quiz.selectedAnswer else {
            return Color.gray.opacity(0.08)
        }

        if index == quiz.currentQuestion.correctAnswer {
            return Color.green.opacity(0.18)
        }

        if index == selected {
            return Color.red.opacity(0.18)
        }

        return Color.gray.opacity(0.08)
    }
}

struct ResultView: View {
    let score: Int
    let total: Int
    let restartAction: () -> Void

    var percentage: Int {
        Int((Double(score) / Double(total)) * 100)
    }

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "trophy.fill")
                .font(.system(size: 60))
                .foregroundStyle(.yellow)

            Text("Quiz Completed!")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("\(score) / \(total)")
                .font(.system(size: 50, weight: .bold))

            Text("Score: \(percentage)%")
                .font(.title2)

            Text(resultMessage)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Restart Quiz") {
                restartAction()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(30)
    }

    private var resultMessage: String {
        switch percentage {
        case 80...100:
            return "Excellent! Keep practicing aptitude questions."
        case 50..<80:
            return "Good attempt! Practice regularly to improve."
        default:
            return "Keep learning and try the quiz again."
        }
    }
}

#Preview {
    ContentView()
}

import Foundation
import SwiftUI

final class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = [
        Question(
            question: "What is 20% of 250?",
            options: ["25", "40", "50", "60"],
            correctAnswer: 2
        ),
        Question(
            question: "If 5 pens cost ₹50, what is the cost of 8 pens?",
            options: ["₹60", "₹70", "₹80", "₹90"],
            correctAnswer: 2
        ),
        Question(
            question: "Find the next number: 2, 4, 8, 16, ?",
            options: ["20", "24", "32", "36"],
            correctAnswer: 2
        ),
        Question(
            question: "A train travels 120 km in 2 hours. What is its speed?",
            options: ["40 km/h", "50 km/h", "60 km/h", "80 km/h"],
            correctAnswer: 2
        ),
        Question(
            question: "If CAT is coded as DBU, how is DOG coded?",
            options: ["EPH", "EOG", "FPH", "DPG"],
            correctAnswer: 0
        ),
        Question(
            question: "Which number is divisible by 3?",
            options: ["124", "125", "126", "127"],
            correctAnswer: 2
        ),
        Question(
            question: "What is the average of 10, 20 and 30?",
            options: ["15", "20", "25", "30"],
            correctAnswer: 1
        ),
        Question(
            question: "A shop gives a 10% discount on ₹500. What is the selling price?",
            options: ["₹450", "₹460", "₹480", "₹490"],
            correctAnswer: 0
        ),
        Question(
            question: "If 3 workers finish a job in 12 days, this simple rate model gives how many worker-days?",
            options: ["15", "24", "36", "48"],
            correctAnswer: 2
        ),
        Question(
            question: "Which is the odd one out?",
            options: ["Apple", "Mango", "Carrot", "Banana"],
            correctAnswer: 2
        )
    ]

    @Published var currentIndex = 0
    @Published var selectedAnswer: Int? = nil
    @Published var score = 0
    @Published var showResult = false

    var currentQuestion: Question {
        questions[currentIndex]
    }

    var progress: Double {
        Double(currentIndex + 1) / Double(questions.count)
    }

    func selectAnswer(_ index: Int) {
        guard selectedAnswer == nil else { return }
        selectedAnswer = index
        if index == currentQuestion.correctAnswer {
            score += 1
        }
    }

    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            selectedAnswer = nil
        } else {
            showResult = true
        }
    }

    func previousQuestion() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        selectedAnswer = nil
    }

    func restart() {
        currentIndex = 0
        selectedAnswer = nil
        score = 0
        showResult = false
    }
}

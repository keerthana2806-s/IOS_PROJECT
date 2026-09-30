import Foundation

struct Question: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswer: Int
}

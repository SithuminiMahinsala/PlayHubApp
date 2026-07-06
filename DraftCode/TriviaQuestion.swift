import Foundation

// Wrapper for the API response
struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}

// Individual question model matching Open Trivia DB keys
struct TriviaQuestion: Codable, Identifiable {
    let id = UUID()
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    // Map JSON snake_case to Swift camelCase
    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
    
    // Helper to decode HTML entities returned by the API
    var decodedQuestion: String {
        question.removingPercentEncoding ?? question
    }
    
    // Combine and shuffle all answers for the UI buttons
    var allAnswers: [String] {
        var answers = incorrectAnswers
        answers.append(correctAnswer)
        return answers.shuffled()
    }
}
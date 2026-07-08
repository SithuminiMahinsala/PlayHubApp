//
//  QuizRushVM.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI
import Combine

// 3 UI states 
enum QuizState {
    case loading
    case loaded
    case failed
}

@MainActor
class QuizRushVM: ObservableObject {
    @Published var questions: [TriviaQuestion] = []
    @Published var currentIndex = 0
    @Published var score = 0
    @Published var streak = 0
    @Published var state: QuizState = .loading
    @Published var isGameOver = false
    
    @AppStorage("quizRushHighScore") var highScore = 0
    
    // Current question 
    var currentQuestion: TriviaQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }
    
    // function called when the screen loads or when Retry is tapped
    func loadQuestions() async {
        state = .loading
        isGameOver = false
        currentIndex = 0
        score = 0
        streak = 0
        
        do {
            let fetchedQuestions = try await TriviaAPI.shared.fetchQuestions()
            if fetchedQuestions.isEmpty {
                state = .failed
            } else {
                self.questions = fetchedQuestions
                self.state = .loaded
            }
        } catch {
            print("Error fetching trivia: \(error)")
            self.state = .failed
        }
    }
    
    // answer selection
    func selectAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }
        
        if answer == question.correctAnswer {
            // Correct tap: increase score + bonus point
            streak += 1
            let streakBonus = streak >= 3 ? 2 : 0 // Bonus points for 3+ streak
            score += (2 + streakBonus)
        } else {
            // Wrong tap: small penalty and reset streak
            score = max(0, score - 1)
            streak = 0
        }
        
        // Advance to next question or end game after 10 questions
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            endGame()
        }
    }
    
    private func endGame() {
        isGameOver = true
        if score > highScore {
            highScore = score
        }
    }
    
    func restart() {
        Task {
            await loadQuestions()
        }
    }
}

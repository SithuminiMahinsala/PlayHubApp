//
//  LightItUpView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI
import Combine

struct LightItUpView: View {
    // Game State
    @State private var score = 0
    @State private var timeRemaining = 60.0
    @State private var isGameOver = false
    @State private var cards: [Card] = []
    
    // Timer for the 60s round,
    @State private var gameTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    // timer for card lighting intervals
    @State private var litTimer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    // high score 
    @AppStorage("lightItUpHighScore") private var highScore = 0
    
    // Level Progression 
    enum Level {
        case l1, l2, l3, l4
        
        var cardCount: Int {
            switch self {
            case .l1: return 3 // 3 cards (row)
            case .l2: return 4 // 4 cards (2x2)
            case .l3: return 6 // 6 cards (2x3)
            case .l4: return 9 // 9 cards (3x3)
            }
        }
        
        var interval: Double {
            switch self {
            case .l1: return 1.5
            case .l2: return 1.2
            case .l3: return 1.0
            case .l4: return 0.8
            }
        }
        
        var litCount: Int {
            return self == .l4 ? 2 : 1 // L4 lights up 2 cards simultaneously
        }
        
        var columns: [GridItem] {
            let count = self == .l1 ? 3 : (self == .l4 ? 3 : 2)
            return Array(repeating: GridItem(.flexible()), count: count)
        }
    }
    
    // current level based on elapsed time in the 60s round
    private var currentLevel: Level {
        if timeRemaining > 45 { return .l1 }      // 0-15s elapsed
        else if timeRemaining > 30 { return .l2 } // 15-30s elapsed
        else if timeRemaining > 15 { return .l3 } // 30-45s elapsed
        else { return .l4 }                       // 45s-end
    }
    
    var body: some View {
        VStack {
            if isGameOver {
                // CALLS THE CENTRAL RESULT VIEW WITH SHARELINK
                ResultView(
                    mode: .lightItUp,
                    score: score,
                    highScore: highScore,
                    onPlayAgain: resetGame
                )
            } else {
                VStack {
                    HStack {
                        Text("Score: \(score)")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("Level: \(levelName)")
                            .font(.headline)
                            .foregroundColor(.orange)
                        Spacer()
                        Text(String(format: "Time: %.0fs", timeRemaining))
                            .font(.title2)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // WHACK-A-MOLE GRID
                    LazyVGrid(columns: currentLevel.columns, spacing: 15) {
                        ForEach(cards) { card in
                            Button(action: { handleTap(on: card) }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(card.isLit ? Color.yellow : Color.gray.opacity(0.3))
                                    .frame(height: 100)
                                    .overlay(
                                        Text(card.isLit ? "TAP!" : "")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    )
                                    .scaleEffect(card.isLit ? 1.05 : 1.0)
                                    .animation(.spring(), value: card.isLit)
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .onAppear(perform: setupGrid)
        .onReceive(gameTimer) { _ in
            guard !isGameOver else { return }
            if timeRemaining > 0 {
                timeRemaining -= 0.1
                adjustGridForLevel()
            } else {
                endGame()
            }
        }
        .onReceive(litTimer) { _ in
            guard !isGameOver else { return }
            lightUpRandomCards()
        }
    }
    
    private var levelName: String {
        switch currentLevel {
        case .l1: return "1"
        case .l2: return "2"
        case .l3: return "3"
        case .l4: return "4 (MAX)"
        }
    }
    
    private func setupGrid() {
        cards = (0..<currentLevel.cardCount).map { Card(id: $0) }
    }
    
    private func adjustGridForLevel() {
        if cards.count != currentLevel.cardCount {
            withAnimation {
                setupGrid()
            }
            // Update the ticking interval 
            litTimer = Timer.publish(every: currentLevel.interval, on: .main, in: .common).autoconnect()
        }
    }
    
    private func lightUpRandomCards() {
        // Dim all cards 
        for i in 0..<cards.count { cards[i].isLit = false }
        
        // Pick random cards to light up based on level rules
        var availableIndices = Array(0..<cards.count)
        for _ in 0..<currentLevel.litCount {
            if let randomIndex = availableIndices.randomElement() {
                withAnimation(.easeInOut(duration: 0.1)) {
                    cards[randomIndex].isLit = true
                }
                availableIndices.removeAll { $0 == randomIndex }
            }
        }
    }
    
    private func handleTap(on card: Card) {
        if card.isLit {
            withAnimation {
                score += 1
                // Turn off card immediately after correct tap
                if let index = cards.firstIndex(where: { $0.id == card.id }) {
                    cards[index].isLit = false
                }
            }
        } else {
            // Wrong tap 
            score = max(0, score - 1)
        }
    }
    
    private func endGame() {
        isGameOver = true
        if score > highScore { highScore = score }
        
        // Record completed session for stats and map 
        StatsVM.shared.addSession(mode: .lightItUp, score: score)
    }
    
    private func resetGame() {
        score = 0
        timeRemaining = 60.0
        isGameOver = false
        setupGrid()
    }
}

#Preview {
    LightItUpView()
}

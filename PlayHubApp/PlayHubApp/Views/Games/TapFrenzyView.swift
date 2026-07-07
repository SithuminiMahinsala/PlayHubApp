//
//  TapFrenzyView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI
import Combine

struct TapFrenzyView: View {
    // Game State
    @State private var score = 0
    @State private var timeRemaining = 10.0
    @State private var isGameOver = false
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // High Score Persistence
    @AppStorage("tapFrenzyHighScore") private var highScore = 0
    
    // Challenge 2: Target (Random position offsets)
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var jumpCounter = 0.0
    
    var body: some View {
        VStack {
            if isGameOver {
                // CALLS THE CENTRAL RESULT VIEW WITH SHARELINK
                ResultView(
                    mode: .tapFrenzy,
                    score: score,
                    highScore: highScore,
                    onPlayAgain: resetGame
                )
            } else {
                // GAME SCREEN
                VStack {
                    // Top Stats
                    HStack {
                        Text("Score: \(score)")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text(String(format: "Time: %.1fs", timeRemaining))
                            .font(.title2)
                            .foregroundColor(timeRemaining < 3 ? .red : .primary)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // TAP BUTTON WITH CHALLENGES
                    Button(action: handleTap) {
                        Text("TAP!")
                            .font(.system(size: 24, weight: .black))
                            .frame(width: buttonSize, height: buttonSize)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .disabled(timeRemaining <= 0)
                    .offset(x: offsetX, y: offsetY) // Challenge 2: Target jump
                    
                    Spacer()
                }
            }
        }
        .onReceive(timer) { _ in
            guard !isGameOver else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 0.1
                jumpCounter += 0.1
                
                // Challenge 2: Jump to random position every 2 seconds
                if jumpCounter >= 2.0 {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        offsetX = CGFloat.random(in: -100...100)
                        offsetY = CGFloat.random(in: -150...150)
                    }
                    jumpCounter = 0.0
                }
            } else {
                endGame()
            }
        }
    }
    
    // Challenge 1: Shrinking Button (Calculates size based on remaining time)
    private var buttonSize: CGFloat {
        let baseSize: CGFloat = 180
        let minSize: CGFloat = 60
        let progress = CGFloat(timeRemaining / 10.0)
        return max(minSize, baseSize * progress)
    }
    
    private func handleTap() {
        score += 1
    }
    
    private func endGame() {
        isGameOver = true
        if score > highScore {
            highScore = score
        }
        
        // RECRODS COMPLETED SESSION FOR STATS CHARTS & MAP PINS
        StatsVM.shared.addSession(mode: .tapFrenzy, score: score)
    }
    
    private func resetGame() {
        score = 0
        timeRemaining = 10.0
        jumpCounter = 0.0
        offsetX = 0
        offsetY = 0
        isGameOver = false
    }
}

#Preview {
    TapFrenzyView()
}

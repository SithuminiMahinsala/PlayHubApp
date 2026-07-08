//
//  ResultView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI

struct ResultView: View {
    let mode: GameMode
    let score: Int
    let highScore: Int
    let onPlayAgain: () -> Void
    

    var shareMessage: String {
        "I just scored \(score) on \(mode.rawValue) — beat that!"
    }
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Game Over!")
                .font(.system(size: 40, weight: .heavy))
            
            VStack(spacing: 10) {
                Text("Final Score")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("\(score)")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.blue)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(20)
            .padding(.horizontal)
            
            Text("High Score: \(highScore)")
                .font(.title3)
                .bold()
                .foregroundColor(.secondary)
            
            //  ShareLink
            ShareLink(item: shareMessage) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share Your Score")
                        .bold()
                }
                .padding()
                .frame(maxWidth: 200)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 3)
            }
            
            Button(action: onPlayAgain) {
                Text("Play Again")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)
            }
            
            Spacer()
        }
        .padding(.top, 40)
    }
}

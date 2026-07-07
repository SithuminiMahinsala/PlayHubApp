//
//  QuizRushView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI

struct QuizRushView: View {
    @StateObject private var viewModel = QuizRushVM()
    
    var body: some View {
        VStack {
            if viewModel.isGameOver {
                // CALLS THE CENTRAL RESULT VIEW WITH SHARELINK
                ResultView(
                    mode: .quizRush,
                    score: viewModel.score,
                    highScore: viewModel.highScore,
                    onPlayAgain: { viewModel.restart() }
                )
            } else {
                // SWITCH ON VIEW STATE
                switch viewModel.state {
                case .loading:
                    VStack(spacing: 15) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Loading Live Trivia...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                case .failed:
                    VStack(spacing: 20) {
                        Image(systemName: "wifi.exclamationmark")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                        Text("Failed to load questions.")
                            .font(.title3)
                        Text("Check your internet connection and try again.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            Task { await viewModel.loadQuestions() }
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    
                case .loaded:
                    if let question = viewModel.currentQuestion {
                        VStack(spacing: 20) {
                            // Top Stats Header
                            HStack {
                                Text("Score: \(viewModel.score)")
                                    .font(.headline)
                                Spacer()
                                if viewModel.streak > 1 {
                                    Text("🔥 \(viewModel.streak) Streak!")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.orange)
                                }
                                Spacer()
                                Text("\(viewModel.currentIndex + 1) of 10")
                                    .font(.headline)
                            }
                            .padding()
                            
                            Spacer()
                            
                            // Question Box
                            Text(question.decodedQuestion)
                                .font(.title2)
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple.opacity(0.1))
                                .cornerRadius(15)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            // 4 Shuffled Answer Buttons
                            VStack(spacing: 12) {
                                ForEach(question.allAnswers, id: \.self) { answer in
                                    Button(action: {
                                        withAnimation {
                                            viewModel.selectAnswer(answer)
                                        }
                                    }) {
                                        Text(answer.removingPercentEncoding ?? answer)
                                            .font(.body)
                                            .bold()
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color.purple)
                                            .foregroundColor(.white)
                                            .cornerRadius(12)
                                            .shadow(radius: 3)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationTitle("Quiz Rush")
        .navigationBarTitleDisplayMode(.inline)
        // Automatically fetch from Open Trivia DB when the view opens
        .task {
            if viewModel.questions.isEmpty {
                await viewModel.loadQuestions()
            }
        }
        // RECORDS COMPLETED SESSION FOR STATS CHARTS & MAP PINS
        .onChange(of: viewModel.isGameOver) { gameOver in
            if gameOver {
                StatsVM.shared.addSession(mode: .quizRush, score: viewModel.score)
            }
        }
    }
}

#Preview {
    QuizRushView()
}

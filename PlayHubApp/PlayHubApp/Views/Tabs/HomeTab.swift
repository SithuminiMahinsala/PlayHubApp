//
//  HomeView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("PlayHub")
                    .font(.system(size: 40, weight: .heavy))
                    .padding(.top, 40)
                
                Text("Select a Game ")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // GAME 1 BUTTON (Week 1)
                NavigationLink(destination: TapFrenzyView()) {
                    HStack {
                        Image(systemName: "hand.tap.fill")
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text("Tap Frenzy")
                                .font(.title2)
                                .bold()
                            Text("Speed & Reflexes")
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                
                // GAME 2 BUTTON (Week 2)
                NavigationLink(destination: LightItUpView()) {
                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text("Light It Up")
                                .font(.title2)
                                .bold()
                            Text("Whack-a-Mole Grid")
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                NavigationLink(destination: QuizRushView()) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text("Quiz Rush")
                                .font(.title2)
                                .bold()
                            Text("Live Trivia API")
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
        
        
    }
}

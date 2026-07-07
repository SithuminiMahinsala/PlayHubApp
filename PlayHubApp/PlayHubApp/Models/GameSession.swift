//
//  GameSession.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import Foundation

enum GameMode: String, Codable, CaseIterable {
    case tapFrenzy = "Tap Frenzy"
    case lightItUp = "Light It Up"
    case quizRush = "Quiz Rush"
}

struct GameSession: Identifiable, Codable {
    let id: UUID
    let mode: GameMode
    let score: Int
    let timestamp: Date
    let latitude: Double
    let longitude: Double
    
    init(mode: GameMode, score: Int, latitude: Double = 0.0, longitude: Double = 0.0) {
        self.id = UUID()
        self.mode = mode
        self.score = score
        self.timestamp = Date()
        self.latitude = latitude
        self.longitude = longitude
    }
}

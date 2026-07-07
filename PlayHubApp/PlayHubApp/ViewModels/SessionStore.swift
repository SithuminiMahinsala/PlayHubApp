//
//  SessionStore.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import Foundation

class SessionStore: ObservableObject {
    static let shared = SessionStore()
    private let storageKey = "savedGameSessions"
    
    @Published var sessions: [GameSession] = []
    
    private init() {
        loadSessions()
    }
    
    // Save a new game session with current GPS coordinates
    func addSession(mode: GameMode, score: Int) {
        let lat = LocationService.shared.currentLatitude
        let lon = LocationService.shared.currentLongitude
        
        let newSession = GameSession(mode: mode, score: score, latitude: lat, longitude: lon)
        sessions.append(newSession)
        saveToUserDefaults()
    }
    
    // Encode array to JSON and save to UserDefaults
    private func saveToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(sessions)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to encode game sessions: \(error)")
        }
    }
    
    // Decode JSON from UserDefaults on app launch
    func loadSessions() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            sessions = try JSONDecoder().decode([GameSession].self, from: data)
        } catch {
            print("Failed to decode game sessions: \(error)")
        }
    }
    
    func clearAllSessions() {
        sessions.removeAll()
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}


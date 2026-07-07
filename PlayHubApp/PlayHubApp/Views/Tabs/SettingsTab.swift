//
//  SettingsTab.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI

struct SettingsTab: View {
    @State private var reminderTime = Date()
    @AppStorage("tapFrenzyHighScore") private var tapScore = 0
    @AppStorage("lightItUpHighScore") private var lightScore = 0
    @AppStorage("quizRushHighScore") private var quizScore = 0
    @State private var showResetAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Daily Challenge Reminder")) {
                    DatePicker("Reminder Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .onChange(of: reminderTime) { newTime in
                            NotificationService.shared.requestPermission { granted in
                                if granted {
                                    NotificationService.shared.scheduleDailyReminder(at: newTime)
                                }
                            }
                        }
                }
                
                Section(header: Text("Data Management")) {
                    Button(role: .destructive, action: { showResetAlert = true }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Reset All High Scores")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Reset High Scores?", isPresented: $showResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    tapScore = 0
                    lightScore = 0
                    quizScore = 0
                }
            } message: {
                Text("This action cannot be undone. All your game statistics will be set to 0.")
            }
        }
    }
}

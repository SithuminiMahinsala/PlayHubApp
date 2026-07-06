import SwiftUI

struct MainTabView: View {
    @State private var reminderTime = Date()
    @AppStorage("tapFrenzyHighScore") private var tapScore = 0
    @AppStorage("lightItUpHighScore") private var lightScore = 0
    @AppStorage("quizRushHighScore") private var quizScore = 0
    @State private var showResetAlert = false
    
    var body: some View {
        TabView {
            // TAB 1: HOME
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "gamecontroller.fill")
                }
            
            // TAB 2: STATS
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            // TAB 3: MAP (Placeholder for lab implementation)

           MapView()
            .tabItem {
             Label("Map", systemImage: "map.fill")
           }
            
            // TAB 4: SETTINGS
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
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}
//
//  MainTabView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // TAB 1: HOME
            HomeTab()
                .tabItem {
                    Label("Home", systemImage: "gamecontroller.fill")
                }
            
            // TAB 2: STATS
            StatsTab()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            // TAB 3: MAP
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            
            // TAB 4: SETTINGS
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}

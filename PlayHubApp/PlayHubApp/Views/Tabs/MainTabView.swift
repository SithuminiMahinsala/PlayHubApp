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
            // HOME
            HomeTab()
                .tabItem {
                    Label("Home", systemImage: "gamecontroller.fill")
                }
            
            // STATS
            StatsTab()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            // MAP
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            
            // SETTINGS
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

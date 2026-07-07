//
//  MapView.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var sessionStore = SessionStore.shared
    @State private var selectedSession: GameSession?
    
    // Default map camera centered on user's last known coordinates
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        NavigationStack {
            VStack {
                if sessionStore.sessions.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "map.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        Text("No Game Sessions Yet")
                            .font(.title2)
                            .bold()
                        Text("Play a round of Tap Frenzy, Light It Up, or Quiz Rush to drop your first location pin!")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else {
                    // MAPKIT WITH MARKERS (Week 4 Requirement)
                    Map(position: $cameraPosition) {
                        ForEach(sessionStore.sessions) { session in
                            Marker("\(session.mode.rawValue): \(session.score) pts",
                                   systemImage: "gamecontroller.fill",
                                   coordinate: CLLocationCoordinate2D(latitude: session.latitude, longitude: session.longitude))
                            .tint(.red)
                        }
                    }
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapScaleView()
                    }
                }
            }
            .navigationTitle("Session Map")
            .onAppear {
                // Request CoreLocation permission when opening the map
                LocationService.shared.requestPermission()
                sessionStore.loadSessions()
            }
        }
    }
}

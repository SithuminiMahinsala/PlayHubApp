import SwiftUI
import MapKit

struct MapView: View {
    // In your real lab app, you can pass your saved [GameSession] array here!
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612), // Default center (Colombo, Sri Lanka)
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    // Sample pins for demonstration during your walkthrough
    let sampleSessions = [
        GameSession(mode: .tapFrenzy, score: 45, latitude: 6.9271, longitude: 79.8612),
        GameSession(mode: .lightItUp, score: 22, latitude: 6.9300, longitude: 79.8650),
        GameSession(mode: .quizRush, score: 18, latitude: 6.9250, longitude: 79.8580)
    ]
    
    var body: some View {
        NavigationStack {
            Map(position: $position) {
                ForEach(sampleSessions) { session in
                    Marker("\(session.mode.rawValue): \(session.score)", coordinate: CLLocationCoordinate2D(latitude: session.latitude, longitude: session.longitude))
                        .tint(.blue)
                }
            }
            .navigationTitle("Game Map")
            .onAppear {
                LocationService.shared.requestPermission()
            }
        }
    }
}
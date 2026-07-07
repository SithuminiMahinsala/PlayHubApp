//
//  LocationService.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import Foundation
import CoreLocation

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    private let manager = CLLocationManager()
    
    @Published var lastLocation: CLLocation?
    
    override private init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Request permission on app launch as required by Week 4 spec
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
    
    // Helper to get current coordinates (defaults to 0.0 if GPS is unavailable in simulator)
    var currentLatitude: Double {
        lastLocation?.coordinate.latitude ?? 6.9271 // Default fallback coordinate
    }
    
    var currentLongitude: Double {
        lastLocation?.coordinate.longitude ?? 79.8612 // Default fallback coordinate
    }
}

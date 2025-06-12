//
//  LocationManager.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation
import CoreLocation
import Combine

// MARK: - LocationManager

/// Handles location permission, location fetching, and country name resolution via reverse geocoding.
class LocationManager: NSObject, ObservableObject {
    
    // MARK: - Private Properties
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    // MARK: - Published Properties
    @Published var country: String? = nil // Full country name (e.g., "India")
    @Published var authorizationStatus: CLAuthorizationStatus? = nil  // Current permission status
    @Published var errorMessage: String? = nil  // Error if location/geocoding fails

    // MARK: - Initializer
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    // MARK: - Location Request

    /// Requests location permission and attempts to fetch location
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    /// Called when the authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus

        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        } else if manager.authorizationStatus == .denied {
            errorMessage = Strings.errorMessage.locationPermissionDenied
        }
    }

    /// Called when location is successfully updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            errorMessage = Strings.errorMessage.faildToGetLocation
            return
        }

        // Reverse geocode to get country
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.errorMessage = "Geocoding error: \(error.localizedDescription)"
                return
            }

            if let countryName = placemarks?.first?.country {
                DispatchQueue.main.async {
                    self.country = countryName
                }
            } else {
                self.errorMessage = Strings.errorMessage.countryNotFound
            }
        }
    }
    
    /// Called when location fetching fails
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Location error: \(error.localizedDescription)"
    }
}

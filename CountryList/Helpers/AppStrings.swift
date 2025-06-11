//
//  AppStrings.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

/// Centralized place for all static user-facing strings in the app.
enum Strings {
    
    // MARK: - Navigation Titles
    enum NavigationTitle {
        static let favourite = "Favourite Countries"
        static let details = "Country Details"
        static let countries = "Countries"
    }

    // MARK: - Button Titles
    enum ButtonTitle {
        static let add = "Add"
        static let ok = "OK"
    }
    
    // MARK: - Info Titles (used in detail view)
    enum Title {
        static func symbol(_ value: String?) -> String {
            "Symbol: \(value ?? " -")"
        }
        
        static func currencyName(_ value: String?) -> String {
            "Currency: \(value ?? " -")"
        }
        
        static func capital(_ value: String?) -> String {
            "Capital: \(value ?? " -")"
        }
        
        static func country(_ name: String) -> String {
            "Name: \(name)"
        }
    }
    
    // MARK: - Placeholders
    enum Placeholder {
        static let search = "Search countries"
        static let noDataFound = "Tap the + button to add a country."
        static let loading = "Please wait..."
    }
    
    // MARK: - Alert Messages
    enum alertMessage {
        static let limtExceeded = "You can only add 5 countries to favourite list."
    }
    
    // MARK: - Alert Titles
    enum alertTitle {
        static let selectionLimit = "Selection Limit"
        static let error = "Error"
    }
    
    // MARK: - Error Messages
    enum errorMessage {
        static let faildToGetLocation = "Failed to get location."
        static let locationPermissionDenied = "Location permission denied."
        static let countryNotFound = "Country not found."
    }
    
}

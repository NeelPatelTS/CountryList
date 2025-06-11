//
//  Route.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

/// Enum representing the navigation routes in the app.
/// Used with `NavigationStack` for type-safe routing.
enum Route: Hashable {
    
    // MARK: - Navigation Cases
    case details(Country)
    case search
}

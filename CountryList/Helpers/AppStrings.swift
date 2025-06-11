//
//  AppStrings.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

enum Strings {
    
    enum NavigationTitle {
        static let favourite = "Favourite Countries"
        static let details = "Country Details"
    }

    enum ButtonTitle {
        static let retry = "Add"
    }
    
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

    enum Placeholder {
        static let search = "Search countries"
        static let noDataFound = "No data found"
        static let loading = "Please wait..."
    }
}

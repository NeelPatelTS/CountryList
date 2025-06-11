//
//  Country.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

struct Country: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let name: String
    let capital: String?
    let currencies: [Currency]?
    let flag: String?
    
}

struct Currency: Codable, Equatable, Hashable {
    let code: String?
    let name: String?
    let symbol: String?
}

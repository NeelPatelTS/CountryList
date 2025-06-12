//
//  Country.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

// MARK: - Country Model
struct Country: Identifiable, Codable, Equatable, Hashable {
    var id: String { name } 
    let name: String
    let capital: String?
    let flags: Flag?
    let currencies: [Currency]?
}

// MARK: - Flag Model
struct Flag: Codable, Equatable, Hashable {
    let svg: String?
    let png: String?
}

// MARK: - Currency Model
struct Currency: Codable, Equatable, Hashable {
    let code: String?
    let name: String?
    let symbol: String?
}


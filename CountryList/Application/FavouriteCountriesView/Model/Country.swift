//
//  Country.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

import Foundation

struct Country: Identifiable, Codable, Equatable, Hashable {
    var id: String { name } 
    let name: String
    let capital: String?
    let flags: Flag?
    let currencies: [Currency]?
}

struct Flag: Codable, Equatable, Hashable {
    let svg: String?
    let png: String?
}

struct Currency: Codable, Equatable, Hashable {
    let code: String?
    let name: String?
    let symbol: String?
}


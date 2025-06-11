//
//  MockAPIService.swift
//  CountryListTests
//
//  Created by Neel on 11/06/25.
//

import Foundation
@testable import CountryList

class MockAPIService: APIServiceProtocol {
    var mockCountries: [Country] = []
    var shouldFail = false
    var errorToThrow: Error = APIError.invalidPath
    
    func fetchCountries() async throws -> [Country] {
        if shouldFail {
            throw errorToThrow
        }
        return mockCountries
    }
}

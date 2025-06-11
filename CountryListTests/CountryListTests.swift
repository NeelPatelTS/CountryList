//
//  CountryListTests.swift
//  CountryListTests
//
//  Created by Neel on 10/06/25.
//

import XCTest
import CoreData
@testable import CountryList

final class CountryListTests: XCTestCase {

    var viewModel: CountryListViewModel!
    var mockContext: NSManagedObjectContext!
    var mockAPIService: MockAPIService!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        mockContext = PersistenceController.shared.container.viewContext
        viewModel = CountryListViewModel(apiService: mockAPIService,context: mockContext)
    }
    override func tearDown() {
        viewModel = nil
        mockContext = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    @MainActor
    private func test_fetchCountries_success() async throws {
        let mockCountry = Country(name: "India", capital: "Delhi", flags: nil, currencies: nil)
        mockAPIService.mockCountries = [mockCountry]
        
        await viewModel.fetchCountries()
        viewModel.getAllCountries()
        
        XCTAssertEqual(viewModel.allCountries.count, 1)
        XCTAssertEqual(viewModel.allCountries.first?.name, "India")
    }
    
    @MainActor
    func test_fetchCountries_failure() async {
        mockAPIService.shouldFail = true
        mockAPIService.errorToThrow = APIError.invalidResponse

        await viewModel.fetchCountries()

        XCTAssertEqual(viewModel.errorMessage, APIError.invalidResponse.description)
    }
    
    @MainActor
    func test_setDefaultFirstCountries_setsFavorite() async {
        let mockCountry = Country(name: "India", capital: "Delhi", flags: nil, currencies: nil)
        mockAPIService.mockCountries = [mockCountry]
        await viewModel.fetchCountries()

        viewModel.setDefaultFirstCountries(name: "India")
        
        XCTAssertTrue(viewModel.favcountries.contains { $0.name == "India" })
    }
    
    @MainActor
    func test_toggleFavorite_addAndRemove() async {
        let mockCountry = Country(name: "India", capital: "Delhi", flags: nil, currencies: nil)
        mockAPIService.mockCountries = [mockCountry]

        await viewModel.fetchCountries()

        viewModel.toggleFavorite(for: mockCountry)
        XCTAssertTrue(viewModel.favcountries.contains { $0.id.lowercased() == "India".lowercased() })
    }

}

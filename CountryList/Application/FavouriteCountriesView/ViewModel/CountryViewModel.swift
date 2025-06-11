//
//  CountryViewModel.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

@MainActor
class CountryListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchCountries() async {
        isLoading = true
        errorMessage = nil
        do {
            countries = try await apiService.fetchCountries()
            print(countries.count)
        } catch let error as APIError {
            errorMessage = error.description
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

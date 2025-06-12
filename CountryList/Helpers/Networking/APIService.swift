//
//  APIService.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

/// Protocol defining the required methods for API calls.
protocol APIServiceProtocol {
    /// Fetches all countries from the REST API.
    func fetchCountries() async throws -> [Country]
}

final class APIService: APIServiceProtocol {
    
    // MARK: - Fetch Countries API
    func fetchCountries() async throws -> [Country] {
        guard let url = URL(string: "https://restcountries.com/v2/all?fields=name,capital,currencies,flags") else {
            throw APIError.invalidPath
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    return try JSONDecoder().decode([Country].self, from: data)
                } catch {
                    throw APIError.unableToDecode(error.localizedDescription)
                }
            case 400:
                throw APIError.badRequest
            case 401:
                throw APIError.authenticationError
            case 403:
                throw APIError.forbidden
            case 404:
                throw APIError.notFound
            case 500...599:
                throw APIError.server
            default:
                throw APIError.failed
            }
            
        } catch let error as URLError {
            switch error.code {
            case .timedOut:
                throw APIError.timeout
            case .notConnectedToInternet:
                throw APIError.offline
            default:
                throw APIError.failed
            }
        } catch {
            throw APIError.failed
        }
    }
}

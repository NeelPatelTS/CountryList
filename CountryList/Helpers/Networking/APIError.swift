//
//  APIError.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidPath
    case timeout
    case offline
    case encodingFailed
    case authenticationError
    case badRequest
    case server
    case unableToDecode(String)
    case failed
    case forbidden
    case notFound
    case invalidResponse
    case unowned
}

extension APIError {
    
    /// API Error description
    var description: String {
        switch self {
        case .invalidPath:
            return "Invalid Path"
        case .timeout:
            return "Server timeout"
        case .offline:
            return "No internet connection"
        case .encodingFailed:
            return "Parameters were nil."
        case .authenticationError:
            return "Authentication failed!"
        case .badRequest:
            return "Bad request."
        case .server:
            return "Server error"
        case .unableToDecode(let error):
            return "We could not decode the response: \(error)"
        case .failed:
            return "Network request failed."
        case .forbidden:
            return "The request was formatted correctly but the server is refusing to supply the requested resource."
        case .notFound:
            return "The resource could not be found."
        case .invalidResponse:
            return "request failed due to invalid response"
        case .unowned:
            return "Unknown error"
        }
    }
}

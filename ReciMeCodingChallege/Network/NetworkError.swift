//
//  NetworkError.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import Foundation
enum NetworkError: LocalizedError {
    case badURL
    case invalidResponse
    case cannotParaseResponse
    case unauthorised
    case badServerResponse
    
    var errorDescription: String? {
        return "Someting went wrong"
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .badURL:
            return "Invalid Base URL"
        case .invalidResponse:
            return "Invalid HTTPURLResponse"
        case .cannotParaseResponse:
            return "Response object and model does not match"
        case .unauthorised:
            return "Unauthorised"
        case .badServerResponse:
            return "Not even sure what happened"
        }
    }
}

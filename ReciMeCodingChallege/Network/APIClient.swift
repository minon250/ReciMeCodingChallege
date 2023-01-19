//
//  APIClient.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
final class APIClient {
    
    static let shared = APIClient()
    
    func send<T:APIRequest>(_ request: T) async throws -> T.Response {
        
        let baseUrlString = AppConfiguration.shared.environment.baseURL
        guard let baseUrl = URL(string: baseUrlString),
              let relativeUrl = URL(string: request.resourceName, relativeTo: baseUrl) else {
            throw NetworkError.badURL
        }
        
        print("🔥 URL \(relativeUrl.absoluteString)")
        var urlRequest = URLRequest(url: relativeUrl)
        urlRequest.httpMethod = request.reqestMethod.rawValue
        let (data,response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch response.statusCode {
        case 200...299:
            let decodedResponse = try? JSONDecoder().decode(T.Response.self, from: data)
            guard let decodedResponse = decodedResponse else {
                throw NetworkError.cannotParaseResponse
            }
            return decodedResponse
        case 401:
            throw NetworkError.unauthorised
        default:
            throw NetworkError.badServerResponse
        }
    
    }
}

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

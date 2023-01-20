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
        
        do {
            let baseUrlString = AppConfiguration.shared.environment.baseURL
            guard let baseUrl = URL(string: baseUrlString),
                  let relativeUrl = URL(string: request.resourceName, relativeTo: baseUrl) else {
                throw NetworkError.badURL
            }
            
            var urlRequest = URLRequest(url: relativeUrl)
            urlRequest.httpMethod = request.reqestMethod.rawValue
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            print("\(relativeUrl.absoluteURL)")
            switch response.statusCode {
            case 200...299:
                let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                return decodedResponse
            case 401:
                throw NetworkError.unauthorised
            default:
                throw NetworkError.badServerResponse
            }
        }
        catch DecodingError.dataCorrupted(let context) {
            print("Decoding error: Data corrupted, \(context.debugDescription)")
            throw NetworkError.cannotParaseResponse
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Decoding error: Key '\(key)' not found, \(context.debugDescription)")
            throw NetworkError.cannotParaseResponse
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Decoding error: Type '\(type)' mismatch, \(context.debugDescription)")
            throw NetworkError.cannotParaseResponse
        } catch {
            throw error
        }
    }
}



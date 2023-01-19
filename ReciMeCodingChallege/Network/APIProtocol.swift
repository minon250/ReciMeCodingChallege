//
//  APIProtocol.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: APIResponse
    var resourceName: String { get }
    var reqestMethod: String {get}
}

protocol APIResponse: Decodable {
    associatedtype Data: Decodable
    var data: Data {get}
}

//
//  APIProtocol.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    var resourceName: String { get }
    var reqestMethod: HTTPRequestMethod {get}
}

protocol APIResponse: Decodable {
    associatedtype Data: Decodable
    var data: Data {get}
}

//
//  RecipesRequest.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
struct RecipesRequest: APIRequest {
    typealias Response = [Recipe]?
    
    var resourceName: String {
        return "profile/\(Session.shared.userId)/posts"
    }
    
    var reqestMethod: HTTPRequestMethod {
        return .GET
    }
}

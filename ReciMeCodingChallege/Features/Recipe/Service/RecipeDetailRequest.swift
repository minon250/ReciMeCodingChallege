//
//  RecipeDetailRequest.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import Foundation
struct RecipeDetailRequest: APIRequest {
    typealias Response = Recipe
    
    var id: String
    
    var resourceName: String {
        return "recipe/\(id)"
    }
    
    var reqestMethod: HTTPRequestMethod {
        return .GET
    }
    
    
}

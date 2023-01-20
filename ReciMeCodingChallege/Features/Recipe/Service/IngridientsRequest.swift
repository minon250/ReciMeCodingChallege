//
//  IngridientsRequest.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import Foundation
struct IngridientsRequest: APIRequest {
    typealias Response = [Ingredient]
    
    var resourceName: String {
        return "recipe/\(id)/ingredients"
    }
    
    var id: String
    
    var reqestMethod: HTTPRequestMethod {
        return .GET
    }
    
    
}

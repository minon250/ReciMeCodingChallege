//
//  Recipe.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let id: String
    let type, title ,imageUrl,difficulty,description,method: String?
    let cookTime,prepTime,numSaves: Int?
    let creator: Creator?
    
    
    var totalTime: String {
        if let cookTime, let prepTime {
            return "\(cookTime + prepTime)m"
        }
        return "n/a"
    }
    
    
    var recipeImageUrl: URL? {
        if let imageUrl {
            return URL(string: imageUrl)
        }
        return nil
    }
}

struct Creator: Decodable {
    let username, profileImageUrl: String?
}

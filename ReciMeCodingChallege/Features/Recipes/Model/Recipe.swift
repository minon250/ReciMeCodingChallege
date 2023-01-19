//
//  Recipe.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let id: String
    let type, title ,recipeURL: String?
}


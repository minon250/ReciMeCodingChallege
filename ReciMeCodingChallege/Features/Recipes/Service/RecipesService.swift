//
//  RecipesService.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
protocol RecipesService {
    func loadRecipes() async throws -> [Recipe]
}
extension NetworkService: RecipesService {
    func loadRecipes() async throws -> [Recipe] {
        let request = RecipesRequest()
        let response = try await APIClient.shared.send(request)
        return response ?? []
    }
}
class FakeRecipesService: RecipesService {
    func loadRecipes() async throws -> [Recipe] {
        return []
    }
}

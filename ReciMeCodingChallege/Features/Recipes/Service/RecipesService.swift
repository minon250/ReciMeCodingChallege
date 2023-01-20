//
//  RecipesService.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
/**
    RecipesService protocol defines an interface for loading recipes and their related data from a remote or local data source.
*/
protocol RecipesService {
    /**
        Asynchronously loads all available recipes.
     
        - Returns: An array of `Recipe` objects.
        - Throws: An error if the request fails.
     */
    func loadRecipes() async throws -> [Recipe]
    
    /**
        Asynchronously loads a specific recipe by its ID.
     
        - Parameters:
            - id: The ID of the recipe to load.
        - Returns: A `Recipe` object.
        - Throws: An error if the request fails or the recipe is not found.
     */
    func loadRecipe(id: String) async throws -> Recipe
    
    /**
        Asynchronously loads the ingredients for a specific recipe by its ID.
     
        - Parameters:
            - id: The ID of the recipe for which to load ingredients.
        - Returns: An array of `Ingredient` objects.
        - Throws: An error if the request fails or the recipe is not found.
     */
    func loadIngredients(id: String) async throws -> [Ingredient]
}

extension NetworkService: RecipesService {
    func loadRecipes() async throws -> [Recipe] {
        let request = RecipesRequest()
        let response = try await APIClient.shared.send(request)
        return response ?? []
    }
    
    func loadRecipe(id: String) async throws -> Recipe {
        let request = RecipeDetailRequest(id: id)
        let response = try await APIClient.shared.send(request)
        return response
    }
    
    func loadIngredients(id: String) async throws -> [Ingredient] {
        let request = IngridientsRequest(id: id)
        let response = try await APIClient.shared.send(request)
        return response
    }
}
class FakeRecipesService: RecipesService {
    func loadRecipes() async throws -> [Recipe] {
        return []
    }
    func loadRecipe(id: String) async throws -> Recipe {
        fatalError()
    }
    func loadIngredients(id: String) async throws -> [Ingredient] {
        fatalError()
    }
}

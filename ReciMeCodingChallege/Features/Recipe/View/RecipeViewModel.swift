//
//  RecipeViewModel.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
final class RecipeViewModel: BaseViewModel {
    @Published var recipe: Recipe
    @Published var ingredients: [Ingredient] = []
    private let service: RecipesService
    
    
    init(recipe: Recipe, service: RecipesService) {
        self.recipe = recipe
        self.service = service
        super.init()
        processing = true
        
    }
    
    func loadRecipe() async {
        do {
            let result = try await service.loadRecipe(id: recipe.id)
            await MainActor.run(body: { [weak self] in
                self?.recipe = result
                self?.processing = false
            })
        }
        catch {
            await handleError(error: error)
        }
    }
    
    func loadIngridients() async {
        do {
            let result = try await service.loadIngredients(id: recipe.id)
            await MainActor.run(body: { [weak self] in
                self?.ingredients = result
            })
        }
        catch {
            await handleError(error: error)
        }
    }
}

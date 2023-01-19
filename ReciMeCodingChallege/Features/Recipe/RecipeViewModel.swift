//
//  RecipeViewModel.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
final class RecipeViewModel: BaseViewModel {
    @Published var recipe: Recipe
    private let service: RecipesService
    
    init(recipe: Recipe, service: RecipesService) {
        self.recipe = recipe
        self.service = service
        super.init()
    }
}

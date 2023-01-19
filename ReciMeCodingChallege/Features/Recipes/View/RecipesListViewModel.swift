//
//  RecipesListViewModel.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
final class RecipesListViewModel: BaseViewModel {
    
    @Published var recipes: [Recipe] = []
    
    private let service: RecipesService
    
    init(service: RecipesService) {
        self.service = service
        super.init()
        processing = true
    }
    
    func loadRecipes() async {
        do {
            let response = try await service.loadRecipes()
            await MainActor.run(body: { [weak self] in
                self?.recipes = response
                self?.processing = false
            })
        }
        catch {
           await handleError(error: error)
        }
    }
}

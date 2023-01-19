//
//  RecipeDetailScreen.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

struct RecipeDetailScreen: View {
    
    @StateObject var vm: RecipeViewModel
    
    var body: some View {
        Text("Showing \(vm.recipe.title ?? "")")
    }
}

//struct RecipeDetailScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailScreen(vm: .init(recipe: .init(id: UUID().uuidString,
//                                                   type: "unknown",
//                                                   title: "Fake Recipe",
//                                                   imageUrl: nil), service: FakeRecipesService()))
//    }
//}

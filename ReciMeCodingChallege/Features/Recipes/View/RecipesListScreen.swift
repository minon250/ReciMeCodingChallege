//
//  RecipesListScreen.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

struct RecipesListScreen: View {
    
    @StateObject var vm: RecipesListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List(vm.recipes) { r in
                    NavigationLink(r.title ?? "") {
                        Text("Going to \(r.id)")
                    }
                }.task {
                    await vm.loadRecipes()
                }
            }
            .overlay {
                ProgressView()
                    .opacity(vm.processing ? 1 : 0)
            }
            .navigationTitle("Recipes")
            .errorAlert(error: $vm.error)
        }
    }
}

struct RecipesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListScreen(vm: .init(service: FakeRecipesService()))
    }
}

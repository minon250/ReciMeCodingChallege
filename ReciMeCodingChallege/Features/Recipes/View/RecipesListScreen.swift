//
//  RecipesListScreen.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

struct RecipesListScreen: View {
    @EnvironmentObject var service: NetworkService
    
    @StateObject var vm: RecipesListViewModel
    @State private var selectedRecipe: Recipe?
    var body: some View {
        NavigationStack {
            List {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(vm.recipes) { item in
                        RecipeTileView(recipe: item)
                            .onTapGesture {
                                self.selectedRecipe = item
                            }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .refreshable {
                await vm.loadRecipes()
            }
            .task {
                await vm.loadRecipes()
            }
            .overlay {
                ProgressView()
                    .opacity(vm.processing ? 1 : 0)
            }
            .sheet(item: $selectedRecipe, content: { recipe in
                RecipeDetailScreen(vm: .init(recipe: recipe, service: service))
            })
            .navigationTitle("Recipes")
            .errorAlert(error: $vm.error)
        }
    }
}

struct RecipesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListScreen(vm: .init(service: FakeRecipesService()))
            .environmentObject(NetworkService())
    }
}

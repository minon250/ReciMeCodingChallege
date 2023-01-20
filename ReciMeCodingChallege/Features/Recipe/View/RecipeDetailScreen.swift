//
//  RecipeDetailScreen.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

struct RecipeDetailScreen: View {
    
    @StateObject var vm: RecipeViewModel
    @State private var serves: Double = 1
    @State private var currentToggle: ServesToggle = .none
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .padding()
                }
            }
            
            List {
                VStack(alignment:.leading,spacing: 20) {
                    if vm.processing {
                        ProgressView()
                    }
                    Text(vm.recipe.title)
                        .font(.title)
                    recipeInfoView
                    
                    AsyncImage(url: vm.recipe.imageUrl) { image in
                        image.resizable()
                            .scaledToFill()
                        
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity,minHeight: 350,maxHeight: 350)
                    .cornerRadius(20)
                    .clipped()
                    
                    Text("About")
                        .font(.title2)
                    Text(vm.recipe.description ?? "")
                        .font(.body)
                    
                    ingredientsView
                    preparationStepsView

                }.listRowSeparator(.hidden)
            }.listStyle(.plain)
            
        }
        .refreshable {
            await loadData()
        }
        
        .task {
            await loadData()
        }
        .errorAlert(error: $vm.error)
        
    }
    
    private func loadData() async {
        await vm.loadRecipe()
        await vm.loadIngridients()
    }
    
    private var recipeInfoView: some View {
        HStack {
            VStack {
                Text("Prep Time")
                Text("\(Int(vm.recipe.prepTime))")
            }
            Spacer()
            VStack {
                Text("Cook Time")
                Text("\(Int(vm.recipe.cookTime))")
            }
            Spacer()
            VStack {
                Text("Diffculty")
                Text(vm.recipe.difficulty.rawValue)
            }
        }
        .font(.caption)
    }
    
    @ViewBuilder
    private var ingredientsView: some View {
        if vm.ingredients.isEmpty {
            Text("No ingredients to display")
        }
        else {
            VStack(alignment:.leading) {
                servesView.padding(.vertical)
                Text("Ingredients")
                    .font(.title2)
                ForEach(vm.ingredients) { ingredient in
                    IngredientRowView(ingredient: ingredient,
                                      serves: $serves,
                                      action: $currentToggle)
                }
            }
        }
    }
    
    private var servesView: some View {
        HStack {
            Image(systemName: "minus.circle")
                .onTapGesture {
                    currentToggle = .decrease
                    if serves > 1 {serves -= 1}
                    
                }
            Text("\(Int(serves)) serves")
            Image(systemName: "plus.circle")
                .onTapGesture {
                    currentToggle = .increase
                    serves += 1
                }
        }.font(.headline)
    }
    
    @ViewBuilder
    private var preparationStepsView: some View {
        if vm.recipe.method.isEmpty {
            Text("No preparation steps available")
        }
        else {
            Text("Method")
                .font(.title2)
            ForEach(vm.recipe.method.indices,id:\.self) { index in
                RecipeStepView(stepNumber: index + 1,
                               stepText: vm.recipe.method[index])
                
            }
        }
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


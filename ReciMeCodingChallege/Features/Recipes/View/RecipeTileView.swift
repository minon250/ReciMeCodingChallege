//
//  RecipeTitleView.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

struct RecipeTileView: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack {
            AsyncImage(url: recipe.recipeImageUrl) { image in
                image.resizable()
                .scaledToFill()
                .overlay(LinearGradient(gradient: Gradient(colors: [.black, .clear]),
                                        startPoint: .bottom, endPoint: .center))

            } placeholder: {
                Text("Loading...")
            }
            .frame(minWidth: 0, maxWidth: .infinity,minHeight: 250,maxHeight: 250)
            .clipped()
            .cornerRadius(20)
            .overlay(alignment:.bottom) {
                HStack {
                    Text(recipe.totalTime)
                    Spacer()
                    if let saves = recipe.numSaves {
                        Text("\(saves)")
                    }
                }
                .padding()
                .foregroundColor(.white)
            }
            
            Text(recipe.title ?? "")
                .font(.headline)
                .lineLimit(1)
        }
    }
}

//struct RecipeTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeTileView(title: "Poke Bowl")
//            .previewLayout(PreviewLayout.sizeThatFits)
//            .padding()
//    }
//}

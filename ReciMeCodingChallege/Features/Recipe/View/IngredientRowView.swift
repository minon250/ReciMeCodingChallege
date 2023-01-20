//
//  IngredientRowView.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import SwiftUI

struct IngredientRowView: View {
    
    let ingredient: Ingredient
    @Binding var serves: Double
    @Binding var action: ServesToggle
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(ingredient.rawProduct != nil ? .green : .red)
                VStack(alignment: .leading) {
                    if let heading = ingredient.headingOrProduct {
                        Text(heading)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    Text(ingredient.topLine(action: action, serves: serves))
                    if let notes = ingredient.preparationNotes {
                        Text(notes)
                            .font(.caption)
                    }
                }
            }.font(.body)
        }
    }
}

//struct IngredientRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientRowView(ingredient: <#Ingredient#>)
//    }
//}

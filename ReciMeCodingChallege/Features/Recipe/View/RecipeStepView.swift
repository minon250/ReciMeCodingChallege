//
//  RecipeStepView.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import SwiftUI

struct RecipeStepView: View {
    var stepNumber: Int
    var stepText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Step \(stepNumber)")
            Text(stepText.removingMarkdown())
                .font(stepText.isMarkdown() ? .headline : .body)
        }
    }
}

struct RecipeStepView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepView(stepNumber: 0, stepText: "Step text")
    }
}

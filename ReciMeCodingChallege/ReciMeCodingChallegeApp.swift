//
//  ReciMeCodingChallegeApp.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI

@main
struct ReciMeCodingChallegeApp: App {
    
    private let service = NetworkService()
    
    var body: some Scene {
        WindowGroup {
            RecipesListScreen(vm: .init(service: service))
        }
    }
}

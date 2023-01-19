//
//  BaseViewModel.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
class BaseViewModel: ObservableObject {
    @Published var error: Error?
    @Published var processing: Bool = false
    
    func handleError(error: Error) async {
        
        await MainActor.run(body: { [weak self] in
            self?.processing = false
            self?.error = error
        })
    }
}

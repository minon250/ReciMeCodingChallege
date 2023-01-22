//
//  Alert+View.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import SwiftUI
extension View {
    /**
     Displays an error alert to the user with a customizable button title.
     
     - Parameters:
        - error: A binding to an optional error of type `Error`.
        - buttonTitle: A string representing the title of the button that dismisses the error alert. Defaults to "OK".
     
     - Returns: A SwiftUI `Alert` view that is presented if the passed in error is not `nil`. The alert displays the error recovery suggestion if it's available in the passed error. The alert contains a button with the title specified in the `buttonTitle` parameter, that when pressed, sets the error binding to `nil`, dismissing the alert.
     */
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}
fileprivate struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    var errorDescription: String? {
        underlyingError.errorDescription ?? "ReciMe"
    }
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }
    /**
     Initializes a `LocalizedAlertError` from a passed in error.
     
     - Parameters:
        - error: An optional error of type `Error`.
     
     - Returns: An instance of `LocalizedAlertError` if the passed in error is a `LocalizedError`, otherwise `nil`.
     */
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}

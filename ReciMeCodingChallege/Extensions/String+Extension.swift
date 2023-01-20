//
//  String+Extension.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import Foundation
extension String {
    func removingMarkdown() -> String {
        return replacingOccurrences(of: "##", with: "")
    }
    func isMarkdown() -> Bool {
        return contains("##")
    }
}

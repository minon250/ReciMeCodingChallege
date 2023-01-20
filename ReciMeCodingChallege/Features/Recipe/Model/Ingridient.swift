//
//  Ingridient.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 20/1/2023.
//

import Foundation
enum ServesToggle {
    case none
    case increase
    case decrease
}

struct Ingredient: Decodable, Identifiable {
    let heading: String?
    let id: Int
    let product: String?
    let quantity: Double?
    let unit: String?
    let productModifier: String?
    let preparationNotes: String?
    let imageFileName: String?
    let rawText: String?
    let rawProduct: String?
    let preProcessedText: String?
    
    var headingOrProduct: String? {
        return heading ?? product
    }
    

    private func formattedQuantity(serves: Double, action: ServesToggle) -> String {
        if let quantity {
            var result = 0.0
            let q = (serves-quantity)/serves
            switch action {
            case .none:
                result = quantity
            case .increase:
                result = q + quantity
            case .decrease:
                result = quantity - q
            }
            return String(result)
        }
        return "-"
    }
    
    func topLine(action: ServesToggle, serves: Double) -> String {
        if let rawProduct {
            return "\(formattedQuantity(serves: serves, action: action)) \(productModifier ?? "") \(rawProduct)"
        }
        return rawText ?? ""

       
    }
    
    enum CodingKeys: CodingKey {
        case heading
        case id
        case product
        case quantity
        case unit
        case productModifier
        case preparationNotes
        case imageFileName
        case rawText
        case rawProduct
        case preProcessedText
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.heading = try container.decodeIfPresent(String.self, forKey: .heading)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? Int(arc4random_uniform(UINT32_MAX))
        self.product = try container.decodeIfPresent(String.self, forKey: .product)
        self.quantity = try container.decodeIfPresent(Double.self, forKey: .quantity)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
        self.productModifier = try container.decodeIfPresent(String.self, forKey: .productModifier)
        self.preparationNotes = try container.decodeIfPresent(String.self, forKey: .preparationNotes)
        self.imageFileName = try container.decodeIfPresent(String.self, forKey: .imageFileName)
        self.rawText = try container.decodeIfPresent(String.self, forKey: .rawText)
        self.rawProduct = try container.decodeIfPresent(String.self, forKey: .rawProduct)
        self.preProcessedText = try container.decodeIfPresent(String.self, forKey: .preProcessedText)
    }
}

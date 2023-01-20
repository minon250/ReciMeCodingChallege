//
//  Recipe.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: String
    let type: RecipeType
    let title: String
    let description: String?
    let recipeUrl: URL?
    let originalPost: URL?
    let imageUrl: URL
    let creator: Creator
    let cookTime: TimeInterval
    let prepTime: TimeInterval
    let servingSize: Int
    let difficulty: Difficulty
    let method: [String]
    let timestamp: Date
    let numLikes: Int
    let numSaves: Int
    let numComments: Int
    let numRecreates: Int
    let rating: Double
    let visibility: Visibility
    let tags: Set<String>
    let cuisine: Cuisine?
    
    var totalTimeFormatted: String {
        //TODO: Use DateComponentsFormatter
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .abbreviated
//        formatter.allowedUnits = [.hour, .minute]
        let minutes = Double(cookTime + prepTime)
        if minutes < 60 {
            return "\(Int(minutes))m"
        } else {
            let hours = minutes / 60
            let remainingMinutes = minutes.truncatingRemainder(dividingBy: 60)
            return remainingMinutes > 0 ? "\(Int(hours))h \(Int(remainingMinutes))m" : "\(Int(hours))h"
        }
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(RecipeType.self, forKey: .type)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.recipeUrl = try container.decodeIfPresent(URL.self, forKey: .recipeUrl)
        self.originalPost = try container.decodeIfPresent(URL.self, forKey: .originalPost)
        self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        self.creator = try container.decode(Creator.self, forKey: .creator)
        self.cookTime = try container.decodeIfPresent(TimeInterval.self, forKey: .cookTime) ?? 0
        self.prepTime = try container.decodeIfPresent(TimeInterval.self, forKey: .prepTime) ?? 0
        self.servingSize = try container.decode(Int.self, forKey: .servingSize)
        self.difficulty = try container.decode(Difficulty.self, forKey: .difficulty)
        self.method = try container.decode(String.self, forKey: .method).components(separatedBy: "\n")
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.numLikes = try container.decode(Int.self, forKey: .numLikes)
        self.numSaves = try container.decode(Int.self, forKey: .numSaves)
        self.numComments = try container.decode(Int.self, forKey: .numComments)
        self.numRecreates = try container.decode(Int.self, forKey: .numRecreates)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.visibility = try container.decode(Visibility.self, forKey: .visibility)
        self.tags = try container.decode(Set<String>.self, forKey: .tags)
        self.cuisine = try container.decodeIfPresent(Cuisine.self, forKey: .cuisine)
    }
    
}

enum RecipeType: String, Codable {
    case recipe = "RECIPE"
}

enum Difficulty: String, Codable {
    case easy = "EASY"
    case medium = "MEDIUM"
    case hard = "HARD"
}

enum Visibility: String, Codable {
    case published = "PUBLISHED"
    case privatee = "PRIVATE"
    case deleted = "DELETED"
}

enum Cuisine: String, Codable {
    case japanese
    case american
    case italian
    case mexican
    case chinese
}

struct Creator: Codable {
    let uid: String
    let username: String
    let profileImageUrl: URL
    let firstname: String?
    let lastname: String?
}

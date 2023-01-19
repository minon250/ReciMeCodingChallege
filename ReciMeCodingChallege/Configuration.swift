//
//  Configuration.swift
//  ReciMeCodingChallege
//
//  Created by Minon Weerasinghe on 19/1/2023.
//

import Foundation
enum AppEnvironment: String {
    case Staging = "staging"
    case Production = "production"

    var baseURL: String {
        switch self {
        case .Staging: return "https://dev.api.recime.app/web-api/"
        case .Production: return "https://dev.api.recime.app/web-api/"
        }
    }
}
struct AppConfiguration {
    
    static var shared = AppConfiguration()
    
    lazy var environment: AppEnvironment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Staging") != nil {
                return AppEnvironment.Staging
            }
        }
        return AppEnvironment.Production
    }()
    
    private init(){}
}

//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Eric on 19/02/2024.
//

import Foundation

enum Endpoints {
    case allOrders
    
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
     // read the value from environment variable
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return AppEnvironment.dev
        }
        
        if env == "TEST" {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}

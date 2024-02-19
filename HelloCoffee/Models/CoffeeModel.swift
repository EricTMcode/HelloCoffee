//
//  CoffeeModel.swift
//  HelloCoffee
//
//  Created by Eric on 18/02/2024.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    @Published private(set) var orders: [Order] = []
    
    let webservice: Webservice
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
}

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
    
    func placeOrder(_ order: Order) async throws {
       let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }
    
    func deleteOrder(_ orderId: Int) async throws {
        let deleteOrder = try await webservice.deleteOrder(orderID: orderId)
        orders = orders.filter { $0.id != deleteOrder.id }
    }
}

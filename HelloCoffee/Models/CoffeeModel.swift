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
    
    func orderByID(_ id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        
        return orders[index]
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
    
    func updateOrder(_ order: Order) async throws {
        let updateOrder = try await webservice.updateOrder(order: order)
        guard let index = orders.firstIndex(where: { $0.id == updateOrder.id }) else {
            throw CoffeeOrderError.invalidOrderId
        }
        orders[index] = updateOrder
    }
}

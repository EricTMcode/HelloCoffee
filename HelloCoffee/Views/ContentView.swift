//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Eric on 18/02/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: CoffeeModel
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!")
                        .accessibilityIdentifier("noOrdersText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            OrderCellView(order: order)
                        }
                        .onDelete(perform: deleteOrder)
                        .accessibilityIdentifier("Delete")
                    }
                }
            }
            .task {
                await populateOrders()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add New Order") {
                        isPresented = true
                    }
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
            .sheet(isPresented: $isPresented) {
                AddCoffeeView()
            }
        }
    }
    
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }
    
    private func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let orderId = order.id else {
                return
            }
            Task {
                do {
                    try await model.deleteOrder(orderId)
                }  catch {
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        ContentView()
            .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}


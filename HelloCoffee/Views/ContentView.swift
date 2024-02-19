//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Eric on 18/02/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: CoffeeModel
    
    var body: some View {
        VStack {
            List(model.orders) { order in
                OrderCellView(order: order)
            }
        }
        .task {
            await populateOrders()
        }
        .padding()
    }
    
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CoffeeModel(webservice: Webservice()))
}


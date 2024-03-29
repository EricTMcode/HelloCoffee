//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Eric on 22/02/2024.
//

import SwiftUI

struct OrderDetailView: View {
    let orderId: Int
    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            if let order = model.orderByID(orderId) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    
                    HStack {
                        Spacer()
                        Button("Delete Order", role: .destructive) {
                            Task {
                                await deleteOrder()
                            }
                        }
                        Button("Edit Order") {
                            isPresented = true
                        }
                        .accessibilityIdentifier("editOrderButton")
                        Spacer()
                    }
                    .sheet(isPresented: $isPresented) {
                        AddCoffeeView(order: order)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private func deleteOrder() async {
        do {
            try await model.deleteOrder(orderId)
            dismiss()
        } catch {
            print(error)
        }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        OrderDetailView(orderId: 1)
            .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}

//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Eric on 19/02/2024.
//

import SwiftUI

struct OrderCellView: View {
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .accessibilityIdentifier("orderNameText")
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("CoffeeNameAndSizeText")
                    .opacity(0.5)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("CoffeePriceText")
        }
    }
}

//#Preview {
//    OrderCellView()
//}

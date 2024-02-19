//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by Eric on 19/02/2024.
//

import SwiftUI

struct AddCoffeeView: View {
    @State private var name = ""
    @State private var coffeeName = ""
    @State private var price = ""
    @State private var coffeSize: CoffeeSize = .medium
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .accessibilityIdentifier("name")
            TextField("Coffee Name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            TextField("Price", text: $price)
                .accessibilityIdentifier("price")
            
            Picker("Select Size", selection: $coffeSize) {
                ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                    Text(size.rawValue)
                        .tag(size)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Place Order") {
                
            }
            .accessibilityIdentifier("placeOrderButton")
            .centerHorizontally()
        }
    }
}

#Preview {
    AddCoffeeView()
}

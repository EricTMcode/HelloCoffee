//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by Eric on 19/02/2024.
//

import SwiftUI

struct AddCoffeeErrors {
    var name = ""
    var coffeeName = ""
    var price = ""
}

struct AddCoffeeView: View {
    var order: Order? = nil
    @State private var name = ""
    @State private var coffeeName = ""
    @State private var price = ""
    @State private var coffeSize: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
    
    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    
    var isValid: Bool {
        
        errors = AddCoffeeErrors()
        
        // This is NOT a business rule
        // This is just UI validation!
        if name.isEmpty {
            errors.name = "Name cannot be empty"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee name cannot be empty"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty"
        } else if !price.isNumeric {
            errors.price = "Price needs to be a number"
        } else if price.isLessThan(1) {
            errors.price = "Price needs to be more than 0"
        }
        
        return errors.name.isEmpty && errors.price.isEmpty && errors.coffeeName.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                Text(errors.name).visible(!errors.name.isEmpty)
                    .font(.caption)
                
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                Text(errors.coffeeName).visible(!errors.coffeeName.isEmpty)
                    .font(.caption)
                
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                Text(errors.price).visible(!errors.price.isEmpty)
                    .font(.caption)
                
                Picker("Select Size", selection: $coffeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue)
                            .tag(size)
                    }
                }
                .pickerStyle(.segmented)
                
                Button(order != nil ? "Update Order" : "Place Order") {
                    if isValid {
                        Task {
                            await saveOrUpdate()
                        }
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
            }
            .navigationTitle(order == nil ? "Add Order" : "Update Order ")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                populateExistingOrder()
            }
        }
    }
    
    private func populateExistingOrder() {
        if let order = order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            coffeSize = order.size
        }
    }
    
    private func placeOrder(_ order: Order) async {
//        let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeSize)
        do {
            try await model.placeOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
    
    private func updateOrder(_ order: Order) async {
        do {
            try await model.updateOrder(order)
        } catch {
            print(error)
        }
    }
    
    private func saveOrUpdate() async {
        if let order {
            var editOrder = order
            editOrder.name = name
            editOrder.total = Double(price) ?? 0
            editOrder.coffeeName = coffeeName
            editOrder.size = coffeSize
            await updateOrder(editOrder)
        } else {
            let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0.0, size: coffeSize)
            await placeOrder(order)
        }
        
        dismiss()
    }
}

#Preview {
    AddCoffeeView()
}

//
//  NumberFormatter+Extensions.swift
//  HelloCoffee
//
//  Created by Eric on 19/02/2024.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}

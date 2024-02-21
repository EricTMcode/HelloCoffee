//
//  String+Extensions.swift
//  HelloCoffee
//
//  Created by Eric on 21/02/2024.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
    
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func isLessThan(_ number: Double) -> Bool {
        if !self.isNumeric {
            return false
        }
        
        guard let value = Double(self) else { return false }
        return value < number
    }
}

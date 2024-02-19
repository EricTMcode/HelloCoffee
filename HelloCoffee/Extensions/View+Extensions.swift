//
//  View+Extensions.swift
//  HelloCoffee
//
//  Created by Eric on 19/02/2024.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}

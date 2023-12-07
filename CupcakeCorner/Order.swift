//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maks Winters on 07.12.2023.
//

import Foundation

@Observable
class Order {
    static let types = ["Vannila", "Chocolate", "Strawberry", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var isSpecialRequestEnabled = false { didSet {
        if isSpecialRequestEnabled == false {
            extraFrosting = false
            addSprinkles = false
        }
    }}
    var extraFrosting = false
    var addSprinkles = false
}

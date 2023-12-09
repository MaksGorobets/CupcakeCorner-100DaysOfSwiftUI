//
//  Order.swift
//  CupcakeCorner
//
//  Created by Maks Winters on 07.12.2023.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _isSpecialRequestEnabled = "isSpecialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _type = "type"
        case _city = "city"
        case _zip = "zip"
        case _streetAddress = "streetAddress"
        case _name = "name"
        case _addSprinkles = "addSprinkles"
        case _quantity = "quantity"
    }
    
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var isAdressValid: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var total: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += 1
        }
        
        if addSprinkles {
            cost += 0.5
        }
        
        return cost
    }
    
}

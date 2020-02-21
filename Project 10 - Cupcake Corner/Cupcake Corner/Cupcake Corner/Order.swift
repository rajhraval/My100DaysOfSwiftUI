//
//  Order.swift
//  Cupcake Corner
//
//  Created by RAJ RAVAL on 19/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
    
    @Published var orderDetails: OrderDetails
    
    init() {
        self.orderDetails = OrderDetails()
    }
    
    enum CodingKeys: CodingKey {
        case orderDetails
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderDetails, forKey: .orderDetails)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderDetails = try container.decode(OrderDetails.self, forKey: .orderDetails)
    }
}

struct OrderDetails: Codable {
    
    // Order Details
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // Address Details
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || name == " " || streetAddress == " " || city == " " || zip == " " {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
        
    }
    
}

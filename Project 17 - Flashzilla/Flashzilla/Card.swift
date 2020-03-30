//
//  Card.swift
//  Flashzilla
//
//  Created by RAJ RAVAL on 28/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittake")
    }
}

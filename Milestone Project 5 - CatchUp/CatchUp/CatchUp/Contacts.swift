//
//  Contacts.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 24/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let image: Image?
}

class Contacts: ObservableObject {
    @Published var contacts = [Contact]()
    
    init() {
        self.contacts = []
    }
}

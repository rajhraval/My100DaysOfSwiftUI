//
//  Contacts.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 01/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import MapKit

class Contact: Identifiable {
    let id = UUID()
    var name: String = "Anon"
    var image: UIImage? = nil
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    init(name: String, image: UIImage?, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.name = name
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
    }
}

class Contacts: ObservableObject {
    @Published var contacts = [Contact]()
    
    init() {
        self.contacts = []
    }
    
    func add(_ contact: Contact) {
        contacts.append(contact)
    }
}

//
//  Favorites.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 07/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        if let resorts = UserDefaults.standard.data(forKey: saveKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(Set<String>.self, from: resorts) {
                self.resorts = decoded
                return
            }
        }
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
}

//
//  Prospect.swift
//  HotProspects
//
//  Created by RAJ RAVAL on 22/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    static let savedPath = "SavedContacts"
    
    init() {
        self.people = []
        self.load()
    }
    
    private func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(Self.savedPath)
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func load() {
        let filename = getDocumentsDirectory().appendingPathComponent(Self.savedPath)
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Unable to load saved Data")
        }
    }
    
}

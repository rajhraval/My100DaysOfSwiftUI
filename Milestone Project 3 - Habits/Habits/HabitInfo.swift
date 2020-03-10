//
//  HabitInfo.swift
//  Habits
//
//  Created by RAJ RAVAL on 10/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation

struct HabitInfo: Identifiable, Codable {
    let id = UUID()
    let habitName: String
    let habitDescription: String
    let habitCategory: String
}

class Habits: ObservableObject {
    @Published var habitItems = [HabitInfo]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habitItems) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let habitItems = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([HabitInfo].self, from: habitItems) {
                self.habitItems = decoded
                return
            }
        }
        self.habitItems = []
    }
}

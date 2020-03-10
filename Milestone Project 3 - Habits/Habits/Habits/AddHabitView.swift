//
//  AddHabitView.swift
//  Habits
//
//  Created by RAJ RAVAL on 10/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var habits: Habits
    
    @State private var name = ""
    @State private var description = ""
    @State private var category = "Work"
    
    static let habitCategories = ["Work", "Health", "Sport", "Art", "Travel", "Reading"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What do you call this Habit?")) {
                    TextField("Name of the Habit", text: $name)
                }
                Section(header: Text("What type of habit is this?")) {
                    Picker("Category", selection: $category) {
                        ForEach(AddHabitView.habitCategories, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section(header: Text("Describe your habit, a bit more")) {
                    TextField("Habit Description", text: $description)
                }
            }
            .navigationBarTitle("Add New Habit")
            .navigationBarItems(trailing: Button("Save Habit") {
                let habit = HabitInfo(habitName: self.name, habitDescription: self.description, habitCategory: self.category)
                self.habits.habitItems.append(habit)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}

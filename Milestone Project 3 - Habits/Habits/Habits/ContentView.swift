//
//  ContentView.swift
//  Habits
//
//  Created by RAJ RAVAL on 16/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habits = Habits()
    
    @State private var showingAddHabitSheet = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.habitItems) { habitItem in
                    ZStack {
                        BlockView(category: habitItem.habitCategory, title: habitItem.habitName, color: self.colorProvider(category: habitItem.habitCategory))
                        NavigationLink(destination: HabitView(habitItem: habitItem)) {
                            EmptyView()
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .environment(\.defaultMinListRowHeight, 135)
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddHabitSheet = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddHabitSheet) {
                AddHabitView(habits: self.habits)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.habitItems.remove(atOffsets: offsets)
    }
    
    func colorProvider(category: String) -> UIColor {
        if category == "Health" {
            return UIColor(red: 1.00, green: 0.46, blue: 0.64, alpha: 1.0)
        } else if category == "Work" {
            return UIColor(red: 1.00, green: 0.65, blue: 0.43, alpha: 1.0)
        } else if category == "Travel" {
            return UIColor(red: 1.00, green: 0.75, blue: 0.32, alpha: 1.0)
        } else if category == "Art" {
            return UIColor(red: 0.31, green: 0.89, blue: 0.76, alpha: 1.0)
        } else if category == "Reading" {
            return UIColor(red: 0.40, green: 0.78, blue: 1.0, alpha: 1.0)
        } else if category == "Sport" {
            return UIColor(red: 0.58, green: 0.40, blue: 1.0, alpha: 1.0)
        } else {
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

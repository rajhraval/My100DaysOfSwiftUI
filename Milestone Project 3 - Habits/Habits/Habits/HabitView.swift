//
//  HabitView.swift
//  Habits
//
//  Created by RAJ RAVAL on 10/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct HabitView: View {

    var habitItem: HabitInfo
    @State private var habitCount = UserDefaults.standard.integer(forKey: "habit")
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 35) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Habit Category")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                    Text(habitItem.habitCategory)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color(colorProvider(category: habitItem.habitCategory)))
                        .multilineTextAlignment(.leading)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Habit Name")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                    Text(habitItem.habitName)
                        .font(.system(size: 22))
                        .fontWeight(.medium)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Habit Description")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                    Text(habitItem.habitDescription)
                        .font(.system(size: 22))
                        .fontWeight(.regular)
                }
            }
            .padding([.leading, .trailing])
            VStack(alignment: .center, spacing: 14) {
                Text("Habit Count")
                    .font(.system(size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                Text("\(habitCount)")
                    .font(.system(size: 43))
                    .foregroundColor(Color(colorProvider(category: habitItem.habitCategory)))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("times")
                    .font(.system(size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 15)
            VStack {
                Button(action: {
                    print("Habit Count Increased")
                    self.habitCount += 1
                    UserDefaults.standard.set(self.habitCount, forKey: "habit")
                }) {
                    ButtonView(text: "Increment Habit Count", color: colorProvider(category: habitItem.habitCategory))
                }
            }
            .padding(.top, 15)
            Spacer()
        }
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

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habitItem: HabitInfo(habitName: "Eat Pumpkin Seeds", habitDescription: "Eat 10-15 Pumpkin seeds daily", habitCategory: "Health"))
    }
}

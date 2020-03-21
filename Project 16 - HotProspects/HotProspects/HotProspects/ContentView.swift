//
//  ContentView.swift
//  HotProspects
//
//  Created by RAJ RAVAL on 19/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                       Text("Red")
                       Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(.red)
                    }
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                       Text("Green")
                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(.green)
                    }
                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                       Text("Blue")
                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.original)
                            .foregroundColor(.blue)
                    }
                }
            
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All Set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Drink Water!"
                content.subtitle = "Time to hydrate yourself"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
            
            Text(results)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

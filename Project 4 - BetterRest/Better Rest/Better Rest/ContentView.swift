//
//  ContentView.swift
//  Better Rest
//
//  Created by RAJ RAVAL on 26/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How much do you want to sleep?")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                               Text("Sleep (in Hours) : \(sleepAmount, specifier: "%g")")
                    }
                }
                
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please select the duration", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }
            }
            .navigationBarTitle("Better Rest")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

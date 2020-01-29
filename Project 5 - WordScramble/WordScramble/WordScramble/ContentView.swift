//
//  ContentView.swift
//  WordScramble
//
//  Created by RAJ RAVAL on 29/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let settings = ["Edit", "Select", "Enable", "Picker", "Access"]
    
    var body: some View {
        List {
            
            Section(header: Text("Some Settings")) {
                Text("Settings 1")
                Text("Settings 2")
                Text("Settings 3")
            }
            
            Section(header: Text("Dynamic Settings")) {
                ForEach(settings, id: \.self) {
                    Text("Settings \($0)")
                }
            }
            
            Section(header: Text("Some Other Settings")) {
                Text("Settings 4")
                Text("Settings 5")
                Text("Settings 6")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

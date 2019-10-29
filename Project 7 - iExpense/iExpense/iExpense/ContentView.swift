//
//  ContentView.swift
//  iExpense
//
//  Created by RAJ RAVAL on 29/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap Count : \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

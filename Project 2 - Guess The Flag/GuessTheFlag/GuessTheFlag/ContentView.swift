//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by RAJ RAVAL on 20/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack(spacing: 24.0) {
            ZStack {
                Color.yellow.frame(width: 366, height: 95)
                Text("Learning SwiftUI is really Fun!")
            }
            Button(action: {
                self.showingAlert = true
            }){
                ZStack {
                    Color.purple.frame(width: 366, height: 95)
                    Text("Show Alert")
                        .foregroundColor(.white)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Alert!"), message: Text("This is an alert message"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            HStack(spacing: 24.0) {
                Color.red.frame(width: 171, height: 212)
                Color.blue.frame(width: 171, height: 212)
            }
            HStack(spacing: 24.0) {
                Color.green.frame(width: 171, height: 212)
                LinearGradient(gradient: Gradient(colors: [.yellow, .red, .orange]), startPoint: .top, endPoint: .bottom)
                    .frame(width: 171, height: 212)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

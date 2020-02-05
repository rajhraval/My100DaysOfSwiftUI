//
//  ContentView.swift
//  iExpense
//
//  Created by RAJ RAVAL on 05/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct LongButton: View {
    var text: String
    var color: UIColor
    
    var body: some View {
        ZStack {
            Color(color).frame(width: 366, height: 56)
                .cornerRadius(9.0)
            Text(text)
                .foregroundColor(.white)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct SecondView: View {
    
    @State private var rotateShape = false
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        VStack(spacing: 36) {
            Text("Button Pressed: \(tapCount)")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Button(action: {
                withAnimation {
                    self.rotateShape.toggle()
                    self.tapCount += 1
                    UserDefaults.standard.set(self.tapCount, forKey: "Tap")
                }
            }) {
                LongButton(text: "Animate", color: UIColor(red:1.00, green:0.00, blue:0.75, alpha:1.0))
            }
            if rotateShape {
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 200, height: 200)
                    .cornerRadius(10.0)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ContentView: View {
    
    @State private var showSheet = false
    @State private var numbers = [Int]()
    @State private var number = 1
    
    var body: some View {
        VStack(spacing: 18.0) {
            List {
                ForEach(numbers, id: \.self) {
                    Text("\($0)")
                }
                .onDelete(perform: removeRows)
            }
            Button(action: {
                self.numbers.append(self.number)
                self.number += 1
            }) {
                LongButton(text: "Add Number", color: UIColor(red: 0.00, green: 0.92, blue: 0.66, alpha: 1.0))
            }
            Button(action: {
                self.showSheet.toggle()
            }) {
                LongButton(text: "Show Sheet", color: UIColor(red: 0.56, green: 0.07, blue: 1.00, alpha: 1.0))
            }
            .sheet(isPresented: $showSheet) {
                SecondView()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

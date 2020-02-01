//
//  ContentView.swift
//  Animations
//
//  Created by RAJ RAVAL on 01/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct SquareCard: View {
    
    var text: String
    var color: UIColor
    
    var body: some View {
        ZStack {
            Color(color).frame(width: 124, height: 124)
                .cornerRadius(20.0)
            Text(text)
                .font(.system(size: 18.0))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct LongCard: View {
    
    var text: String
    var color: UIColor
    
    var body: some View {
        ZStack {
            Color(color).frame(width: 317, height: 124)
                .cornerRadius(15.0)
            Text(text)
                .font(.system(size: 18.0))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct FancyButton: View {
    
    var text: String
    var color: UIColor
    
    var body: some View {
        ZStack {
            Color(color).frame(width: 366, height: 56)
                .cornerRadius(9.0)
            Text(text)
                .font(.system(size: 18.0))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }

}

struct ContentView: View {
    
    let customRed = UIColor(red:1.00, green:0.24, blue:0.24, alpha:1.0)
    let customOrange = UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0)
    let customYellow = UIColor(red:1.00, green:0.81, blue:0.16, alpha:1.0)
    let customGreen = UIColor(red:0.21, green:0.91, blue:0.36, alpha:1.0)
    let customSkyBlue = UIColor(red:0.00, green:0.84, blue:1.00, alpha:1.0)
    let customIndigo = UIColor(red:0.39, green:0.18, blue:1.00, alpha:1.0)
    let customPurple = UIColor(red:0.74, green:0.06, blue:0.88, alpha:1.0)
    let customPink = UIColor(red:1.00, green:0.40, blue:0.61, alpha:1.0)
    
    @State private var animationAmountRed = 0.0
    @State private var animationAmountOrange = 0.0
    @State private var animationAmountYellow = 0.0
    @State private var animationAmountGreen = 0.0
    
    @State private var animationAmountBlue: CGFloat = 1
    @State private var animationAmountIndigo: CGFloat = 1
    @State private var animationAmountPurple: CGFloat = 1
    @State private var animationAmountPink: CGFloat = 1
    
    @State private var blueScale = true
    @State private var indigoScale = true
    @State private var purpleScale = true
    @State private var pinkScale = true
    
    var body: some View {
        VStack(spacing: 56.0) {
            HStack(spacing: 69.0) {
                
                Button(action: {
                    withAnimation {
                        self.animationAmountRed += 360.0
                    }
                }) {
                    SquareCard(text: "Rotate X", color: customRed)
                }
                .rotation3DEffect(.degrees(animationAmountRed), axis: (x: 1, y: 0, z: 0))
                
                Button(action: {
                    withAnimation {
                        self.animationAmountOrange += 360.0
                    }
                }) {
                    SquareCard(text: "Rotate Y", color: customOrange)
                }
                .rotation3DEffect(.degrees(animationAmountOrange), axis: (x: 0, y: 1, z: 0))
                
            }
            HStack(spacing: 69.0) {
                
                Button(action: {
                    withAnimation {
                        self.animationAmountYellow += 360.0
                    }
                }) {
                    SquareCard(text: "Rotate Z", color: customYellow)
                }
                .rotation3DEffect(.degrees(animationAmountYellow), axis: (x: 0, y: 0, z: 1))
                
                Button(action: {
                    withAnimation {
                        self.animationAmountGreen += 180.0
                    }
                }) {
                    SquareCard(text: "180 spin", color: customGreen)
                }
                .rotation3DEffect(.degrees(animationAmountGreen), axis: (x: 0, y: 1, z: 0))
                
            }
            HStack(spacing: 69.0) {
                
                Button(action: {
                    self.blueScale.toggle()
                    if self.blueScale {
                        self.animationAmountBlue = 1
                    } else {
                        self.animationAmountBlue = 0
                    }
                }) {
                    SquareCard(text: "Ease In", color: customSkyBlue)
                }
                .scaleEffect(animationAmountBlue)
                .animation(.easeIn)
                
                Button(action: {
                    self.indigoScale.toggle()
                    if self.indigoScale {
                        self.animationAmountIndigo = 1
                    } else {
                        self.animationAmountIndigo = 0
                    }
                }) {
                    SquareCard(text: "Easy Out", color: customIndigo)
                }
                .scaleEffect(animationAmountIndigo)
                .animation(.easeOut)
            }
            
            Button(action: {
                self.purpleScale.toggle()
                if self.purpleScale {
                    self.animationAmountPurple = 1
                } else {
                    self.animationAmountPurple = 0
                }
            }) {
                LongCard(text: "Spring", color: customPurple)
            }
            .scaleEffect(animationAmountPurple)
            .animation(.interpolatingSpring(stiffness: 5, damping: 1))
            
            Button(action: {
                self.pinkScale.toggle()
                if self.pinkScale {
                    self.animationAmountPink = 1
                } else {
                    self.animationAmountPink = 0
                }
            }) {
                FancyButton(text: "Ease In & Ease Out", color: customPink)
            }
            .scaleEffect(animationAmountPink)
            .animation(.easeInOut)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

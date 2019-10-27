//
//  ContentView.swift
//  GuessTheFlags
//
//  Created by RAJ RAVAL on 13/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

//Image(image)

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
    
    @State private var angle = [0.0, 0.0, 0.0]
    @State private var opacityValue = [1.0, 1.0, 1.0]
    
    @State private var stiffness = [0.0, 0.0, 0.0]
    @State private var damping = [0.0, 0.0, 0.0]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                    }
                    .rotationEffect(.degrees(self.angle[number]))
                    .opacity(self.opacityValue[number])
                    .animation(.default)
                    
                }
                Spacer()
                Text("Score: \(userScore)")
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            scoreMessage = "That is the flag of \(countries[correctAnswer])"
            correctFlagAnimation()
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That is the flag of \(countries[number])"
            wrongFlagAnimation()
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        angle = [0.0, 0.0, 0.0]
        opacityValue = [1.0, 1.0, 1.0]
        stiffness = [0.0, 0.0, 0.0]
        damping = [0.0, 0.0, 0.0]
    }
    
    func correctFlagAnimation() {
        for flag in 0...2 {
            if flag == correctAnswer {
                angle[flag] = 360
            } else {
                opacityValue[flag] = 0.25
            }
        }
    }
    
    func wrongFlagAnimation() {
        for flag in 0...2 {
            if flag != correctAnswer {
                stiffness[flag] = 3
                damping[flag] = 5
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

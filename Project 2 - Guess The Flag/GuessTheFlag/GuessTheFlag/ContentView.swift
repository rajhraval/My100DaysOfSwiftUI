//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by RAJ RAVAL on 20/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .frame(width: 213, height: 120)
            .cornerRadius(6.0)
            .shadow(radius: 2.0)
    }
}

struct smallText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 22))
            .fontWeight(.regular)
            .multilineTextAlignment(.center)
    }
}

struct bigText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 32))
            .fontWeight(.bold)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var angle = 0.0
    @State private var wrongFlag = false
    
    var body: some View {
        VStack(spacing: 36.0) {
            VStack(spacing: 12.0) {
                smallText(text: "Tap the flag of")
                bigText(text: countries[correctAnswer])
            }
            ForEach(0 ..< 3) {
                number in
                Button(action: {
                    self.flagTapped(number)
                }) {
                    FlagImage(text: self.countries[number])
                        .rotation3DEffect(number == self.correctAnswer ? .degrees(self.angle) : .zero, axis: (x: 0, y: 1, z: 0))
                        .animation(.default)
                }
            }
            VStack(spacing: 12.0) {
                smallText(text: "You score is")
                bigText(text: "\(score)")
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreMessage = "It is the flag of \(countries[correctAnswer])!"
            score += 1
            angle += 360.0
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's The flag of \(countries[number])!"
            score -= 1
            wrongFlag = true
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

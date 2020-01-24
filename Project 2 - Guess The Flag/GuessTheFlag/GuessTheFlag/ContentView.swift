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
            .cornerRadius(5.0)
            .shadow(radius: 2.0)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, .red, .orange, .yellow]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30.0) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) {
                    number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(text: self.countries[number])
                    }
                }
                VStack {
                    Text("Your Score is")
                        .foregroundColor(.white)
                    Text("\(score)")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
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
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's The flag of \(countries[number])!"
            score -= 1
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

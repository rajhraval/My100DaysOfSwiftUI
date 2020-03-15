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
    
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var score = 0
    @State private var selectedNumber = 0
    
    @State private var correctFlag = false
    @State private var wrongFlag = false
    @State private var makeFlagOpaque = false
    @State private var showingScore = false
    
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        VStack(spacing: 36.0) {
            VStack(spacing: 12.0) {
                smallText(text: "Tap the flag of")
                bigText(text: countries[correctAnswer])
            }
            ForEach(0 ..< 3) {
                number in
                Button(action: {
                    withAnimation {
                        self.flagTapped(number)
                    }
                }) {
                    FlagImage(text: self.countries[number])
                        .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown Flag"]))
                }
                .rotation3DEffect(.degrees(self.correctFlag && self.selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                .opacity(self.makeFlagOpaque && !(self.selectedNumber == number) ? 0.25 : 1)
                .rotation3DEffect(.degrees(self.wrongFlag && self.selectedNumber == number ? 360 : 0), axis: (x: 0, y: 0, z: 1))
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
        self.selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct!"
            scoreMessage = "It is the flag of \(countries[correctAnswer])!"
            score += 1
            correctFlag = true
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
        wrongFlag = false
        correctFlag = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

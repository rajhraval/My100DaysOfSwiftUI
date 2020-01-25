//
//  ContentView.swift
//  Rock, Papers and Scissors
//
//  Created by RAJ RAVAL on 25/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct FancyButton: View {
    var text: String
    var image: String
    var color: UIColor
    var body: some View {
        ZStack(alignment: .center) {
            Color(color).frame(width: 114, height: 198)
                .cornerRadius(4.0)
            VStack(spacing: 33.0) {
                Spacer()
                    .frame(height: 24.0)
                Image(image)
                    .renderingMode(.original)
                    .frame(width: 32, height: 42)
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct gameCommand: View {
    var grammarText: String
    var command: String
    var body: some View {
        VStack(spacing: 14.0) {
            Text(grammarText)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Text(command)
                .font(.system(size: 32))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct gameInfo: View {
    var infoText: String
    var info: String
    var body: some View {
        VStack(spacing: 14.0) {
            Text(infoText)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            Text(info)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct ContentView: View {
    
    @State private var fancyButtons = [
        FancyButton(text: "Rock", image: "Fist", color: UIColor(red:1.00, green:0.40, blue:0.61, alpha:1.0)),
        FancyButton(text: "Paper", image: "Hi", color: UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0)),
        FancyButton(text: "Yo", image: "Yo", color: UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0))]
    
    @State private var moves = ["ROCK", "PAPER", "SCISSORS"].shuffled()
    @State private var move = Int.random(in: 0...2)
    @State private var score = 0
    @State private var round = 1
    @State private var playerShouldWin = Bool.random()
    
    let rounds = 10
    
    var body: some View {
        VStack(spacing: 56.0) {
            HStack(alignment: .center, spacing: 82) {
                gameInfo(infoText: "Score", info: "\(score)")
                gameInfo(infoText: "Round", info: "\(round)/\(rounds)")
            }
            gameCommand(grammarText: "It's", command: moves[move])
            gameCommand(grammarText: "You need to", command: playerShouldWin ? "WIN" : "LOSE")
            HStack(spacing: 10.0) {
                ForEach(0 ..< 3) {
                    number in
                    Button(action: {
                        self.buttonTapped(number)
                    }) {
                        self.fancyButtons[number]
                    }
                }
            }
        }
    }
    
    func buttonTapped(_ number: Int) {
        if number != move {
            score += 1
            round += 1
        } else {
            score -= 1
            round += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

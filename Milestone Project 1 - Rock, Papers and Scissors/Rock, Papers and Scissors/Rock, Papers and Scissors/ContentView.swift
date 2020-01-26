//
//  ContentView.swift
//  Rock, Papers and Scissors
//
//  Created by RAJ RAVAL on 25/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

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

struct ContentView: View {
    
    @State private var moves = ["ROCK", "PAPERS", "SCISSORS"]
    @State private var computerMove = Int.random(in: 0...2)
    @State private var playerShouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let rounds = 10
    
    let customOrange = UIColor(red: 1.00, green: 0.62, blue: 0.00, alpha: 1.0)
    let customPink = UIColor(red: 1.00, green: 0.40, blue: 0.61, alpha: 1.0)
    let customPurple = UIColor(red: 0.56, green: 0.07, blue: 1.00, alpha: 1.0)
    let customRed = UIColor(red: 1.00, green: 0.24, blue: 0.24, alpha: 1.0)
    let customGreen = UIColor(red: 0.21, green: 0.91, blue: 0.36, alpha: 1.0)
    
    let images = ["Fist", "Hi", "Yo"]
    let colors = [UIColor(red: 1.00, green: 0.40, blue: 0.61, alpha: 1.0), UIColor(red: 0.56, green: 0.07, blue: 1.00, alpha: 1.0), UIColor(red: 1.00, green: 0.62, blue: 0.00, alpha: 1.0)]
    
    
    var body: some View {
        VStack(spacing: 56.0) {
            HStack(alignment: .center, spacing: 82.0) {
                gameInfo(infoText: "Score", info: "\(score)")
                gameInfo(infoText: "Round", info: "\(round)/\(rounds)")
            }
            VStack(spacing: 14.0) {
                Text("It's")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text(moves[computerMove])
                    .foregroundColor((computerMove == 0) ? Color(customPink) : (computerMove == 1) ? Color(customPurple) : (computerMove == 2) ? Color(customOrange) : .black)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            VStack(spacing: 14.0) {
                Text("You need to")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                Text(playerShouldWin ? "WIN" : "LOSE")
                    .foregroundColor(playerShouldWin ? Color(customGreen) : Color(customRed))
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 10.0) {
                ForEach(0 ..< moves.count) { number in
                    Button(action: {
                        self.buttonTapped(number)
                    }) {
                        FancyButton(text: self.moves[number], image: self.images[number], color: self.colors[number])
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(round > 10 ? "Restart" : "Continue")) {
                    self.playAgain()
                })
            }
        }
    }
    
    func playAgain() {
        computerMove = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
    }
    
    func buttonTapped(_ number: Int) {
        round += 1
        if computerMove == number {
            score += 0
            alertTitle = "It's a Tie!"
            alertMessage = "You score 0 points."
        } else if (computerMove == 0 && number == 1 && playerShouldWin == true) || (computerMove == 1 && number == 2 && playerShouldWin == true) || (computerMove == 2 && number == 0 && playerShouldWin == true) {
            score += 1
            alertTitle = "You Win!"
            alertMessage = "You score 1 point."
        } else if (computerMove == 0 && number == 2 && playerShouldWin == false) || (computerMove == 1 && number == 0 && playerShouldWin == false) || (computerMove == 2 && number == 1 && playerShouldWin == false) {
            score += 1
            alertTitle = "You Lose, But Obeyed!"
            alertMessage = "You still score 1 point."
        } else {
            score -= 1
            alertTitle = "You disobeyed the command."
            alertMessage = "You get -1 point."
        }
        
        if round > 10 {
            print(round)
            alertTitle = "Game Over! Your score is \(score)"
            alertMessage = "Do you want to play it again?"
            score = 0
            round = 1
        }
        
        showingAlert = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

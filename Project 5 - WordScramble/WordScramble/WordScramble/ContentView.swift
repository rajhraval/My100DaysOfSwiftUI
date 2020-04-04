//
//  ContentView.swift
//  WordScramble
//
//  Created by RAJ RAVAL on 29/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                GeometryReader { fullView in
                    ScrollView(.vertical) {
                        ForEach(0..<self.usedWords.count, id: \.self) { index in
                            GeometryReader { geo in
                                HStack {
                                Image(systemName: "\(self.usedWords[index].count).circle")
                                    .foregroundColor(Color(red: Double(geo.frame(in: .global).minY / fullView.size.height),
                                    green: 0.9,
                                    blue: 0.1))
                                Text("\(self.usedWords[index])")
                                    .font(.title)
                                    .foregroundColor(Color(red: Double(geo.frame(in: .global).minY / fullView.size.height),
                                    green: 0.1,
                                    blue: 0.2))
                                }
                                .frame(width: fullView.size.width, alignment: Alignment.leading)
                                .offset(x: (geo.frame(in: .global).minY - (fullView.size.height) > 8 ? geo.frame(in: .global).minY - (fullView.size.height) : 8),
                                        y: 0)
                                
                            }
                            .frame(height: 40)
                        }
                    }
                }
                
                Text("Score: \(score)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button(action: startGame){
                Image(systemName: "arrow.clockwise.circle")
                    .renderingMode(.original)
                Text("Restart Game")
                    .foregroundColor(.black)
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func startGame() {
        score = 0
        usedWords.removeAll()
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Try to be more original.")
            score -= 1
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them.")
            score -= 1
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "This isn't a real word.")
            score -= 1
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        score += 1
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if word.count < 3 || word == rootWord {
            return false
        }
        
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

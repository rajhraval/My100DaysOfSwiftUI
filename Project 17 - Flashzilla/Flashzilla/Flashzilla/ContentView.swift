//
//  ContentView.swift
//  Flashzilla
//
//  Created by RAJ RAVAL on 26/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var engine: CHHapticEngine?
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    @State private var showingSettingScreen = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(Color.black)
                        .opacity(0.75)
                )
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.showingEditScreen = true
                            }) {
                                Image(systemName: "plus.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                        }
                        
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.showingSettingScreen = true
                            }) {
                                Image(systemName: "gear")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                    if differentiateWithoutColor || accessibilityEnabled {
                        VStack {
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        self.removeCard(at: self.cards.count - 1)
                                    }
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .accessibility(label: Text("Wrong"))
                                .accessibility(hint: Text("Mark your answer as being incorrect."))
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        self.removeCard(at: self.cards.count - 1)
                                    }
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .accessibility(label: Text("Correct"))
                                .accessibility(hint: Text("Mark your answer as being correct."))
                                
                            }
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                        }
                    }
                    ForEach(0..<cards.count, id: \.self) {
                        index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if timeRemaining == 0 {
                    Text("GAME OVER")
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .onAppear(perform: removeAllCards)
                    Spacer()
                        .frame(height: 74)
                }
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .sheet(isPresented: $showingSettingScreen) {
            SettingsView()
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func removeAllCards() {
        cards.removeAll()
        prepareAndPerformHaptics()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func prepareAndPerformHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
            performCustomHaptics()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func performCustomHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

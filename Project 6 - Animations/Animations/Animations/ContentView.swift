//
//  ContentView.swift
//  Animations
//
//  Created by RAJ RAVAL on 01/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct GridStack: View {
    
    let color: UIColor
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(color)
                .frame(width: 153, height: 95)
                .cornerRadius(10)
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded { _  in
                            withAnimation(.spring()) {
                                self.dragAmount = .zero
                            }
                    }
                )
        }
    }
}

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
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: 180, anchor: .leading),
            identity: CornerRotateModifier(amount: 0, anchor: .trailing)
        )
    }
}

struct ContentView: View {
    
    @State private var dragAmount = CGSize.zero
    @State private var isShowingShape = false
    
    @State private var snakeDragAmount = CGSize.zero
    
    let colors = [
        UIColor(red:1.00, green:0.00, blue:0.75, alpha:1.0),
        UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0)
    ]
    
    let letters = Array("Green Python")
    
    var body: some View {
        VStack(spacing: 36) {
            HStack(spacing: 36) {
                GridStack(color: colors[0])
                GridStack(color: colors[1])
            }
            HStack(spacing: 36) {
                GridStack(color: colors[0])
                GridStack(color: colors[1])
            }
            Button(action: {
                withAnimation {
                    self.isShowingShape.toggle()
                }
            }) {
                LongButton(text: "Animate", color: UIColor(red:0.31, green:0.89, blue:0.76, alpha:1.0))
            }
            if isShowingShape {
                Rectangle()
                    .fill(Color(UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0)))
                    .frame(width: 342, height: 121)
                    .cornerRadius(10.0)
                    .transition(.pivot)
            }
            HStack(spacing: 0) {
                ForEach(0 ..< letters.count) {
                    Text(String(self.letters[$0]))
                        .padding(5)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color(UIColor(red:0.23, green:0.66, blue:0.00, alpha:1.0)))
                        .offset(self.snakeDragAmount)
                        .animation(Animation.default.delay(Double($0) / 20))
                }
            }
            //.cornerRadius(26.5)
            .gesture(
                DragGesture()
                    .onChanged { self.snakeDragAmount = $0.translation }
                    .onEnded { _ in self.snakeDragAmount = .zero }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

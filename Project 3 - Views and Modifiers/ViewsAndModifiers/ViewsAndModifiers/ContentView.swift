//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by RAJ RAVAL on 23/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct MiniCard: View {
    var text: String
    var color: UIColor

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Color(color).frame(width: 175, height: 105)
                    .cornerRadius(9.0)
                HStack {
                    Spacer()
                        .frame(width: 22.0)
                    Text(text)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    
                }
            }
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
                .font(.body)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.black)
                .padding(5)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let vSpace: CGFloat
    let hSpace: CGFloat
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(spacing: vSpace) {
            ForEach(0 ..< rows) { row in
                HStack(spacing: self.hSpace) {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, vSpace: CGFloat, hSpace: CGFloat, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
        self.vSpace = vSpace
        self.hSpace = hSpace
    }
    
}

struct ContentView: View {
    
    let miniCardOne = MiniCard(text: "Study", color: UIColor(red: 0.56, green: 0.07, blue: 1.00, alpha: 1.0))
    let miniCardTwo = MiniCard(text: "Games", color: UIColor(red: 0.00, green: 0.92, blue: 0.66, alpha: 1.0))
    let miniCardThree = MiniCard(text: "Travel", color: UIColor(red: 1.00, green: 0.62, blue: 0.00, alpha: 1.0))
    let miniCardFour = MiniCard(text: "Music", color: UIColor(red: 1.00, green: 0.24, blue: 0.24, alpha: 1.0))
    
    let longButton = LongButton(text: "Let's Play!", color: UIColor(red: 1.00, green: 0.40, blue: 0.61, alpha: 1.0))
    
    var body: some View {
        VStack(spacing: 24.0) {
            HStack(spacing: 16.0) {
                miniCardOne
                miniCardTwo
            }
            HStack(spacing: 16.0) {
                miniCardThree
                miniCardFour
            }
            longButton
            Color.yellow.frame(width: 366, height: 121)
                .cornerRadius(9.0)
                .watermarked(with: "This is a SwiftUI modifier.")
            GridStack(rows: 3, columns: 3, vSpace: 24.0, hSpace: 16.0) { row, col in
                HStack(spacing: 16.0) {
                    Image("Group")
                        .renderingMode(.original)
                        .frame(width: 62, height: 28)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by RAJ RAVAL on 16/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SwiftUI

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(LargeTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Creating Text using\n a custom modifier")
        .modifier(LargeTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

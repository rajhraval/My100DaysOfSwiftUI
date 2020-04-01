//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by RAJ RAVAL on 01/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@random_person")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("Person")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            .background(Color.yellow)
            VStack {
                Text("Full Name:")
                Text("RANDOM PERSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
            .background(Color.green)
        }
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

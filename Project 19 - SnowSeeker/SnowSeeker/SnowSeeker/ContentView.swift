//
//  ContentView.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 05/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Bond")
            Text("Country: England")
            Text("Cars: Aston Martin DB5 and Aston Martin Vanquish")
        }
    }
}

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

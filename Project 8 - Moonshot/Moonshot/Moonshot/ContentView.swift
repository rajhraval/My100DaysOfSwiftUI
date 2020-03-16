//
//  ContentView.swift
//  Moonshot
//
//  Created by RAJ RAVAL on 08/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showName = false
    
    var body: some View {
        NavigationView {
            List(mission) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .accessibility(removeTraits: .isImage)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.showName ? mission.formattedCrew: mission.formattedLaunchDate)
                    }
                    .accessibilityElement(children: .combine)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                HStack {
                    Toggle(isOn: $showName) {
                        Text("Show Crew Names")
                    }
                    .accessibility(label: Text("Show Crew Names instead of mission launch date"))
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

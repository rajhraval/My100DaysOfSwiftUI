//
//  AstronautView.swift
//  Moonshot
//
//  Created by RAJ RAVAL on 10/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .layoutPriority(1)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(2)
                    VStack {
                        Text("Missions Flown:")
                            .font(.headline)
                        List(self.missions) { mission in
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var missionsFlown = [Mission]()
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in allMissions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id }) {
                missionsFlown.append(mission)
            }
        }
        
        self.missions = missionsFlown
    }
    
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: mission)
    }
}

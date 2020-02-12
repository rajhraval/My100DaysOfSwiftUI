//
//  Mission.swift
//  Moonshot
//
//  Created by RAJ RAVAL on 09/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrew: String {
        
        var memberName = ""
        
        for member in crew {
            memberName += "\(member.name.capitalized), "
        }
        
        return String(memberName.dropLast(2))
    }
}

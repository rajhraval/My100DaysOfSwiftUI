//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 06/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct SkiDetailsView: View {
    
    let resort: Resort
    
    var body: some View {
        VStack {
            Text("Elevation: \(resort.elevation)m")
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}

//
//  ResortsDetailView.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 06/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ResortsDetailView: View {
    
    let resort: Resort
    
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Averge"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        VStack {
            Text("Size: \(size)")
            Text("Price: \(price)")
        }
    }
}

struct ResortsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortsDetailView(resort: Resort.example)
    }
}

//
//  DetailView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 02/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @ObservedObject var contactItems = Contacts()
    
    var index = 0
    let defaultImage = UIImage(systemName: "person")!
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: contactItems.contacts[index].image ?? defaultImage)
                Text(contactItems.contacts[index].name)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(contactItems: Contacts(), index: 0)
    }
}

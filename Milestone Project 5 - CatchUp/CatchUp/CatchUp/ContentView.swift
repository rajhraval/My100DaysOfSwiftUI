//
//  ContentView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 17/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contactItems = Contacts()
    
    @State private var showingAddContact = false
    
    let defaultImage = UIImage(systemName: "person")!
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contactItems.contacts) { contact in
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 64, height: 64)
                            Image(uiImage: contact.image ?? self.defaultImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        }
                        Text(contact.name)
                    }
                }
            }
            .navigationBarTitle("CatchUp")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddContact = true
                }) {
                    Image(systemName: "plus")
                    Text("Add Contact")
                }
            )
            .sheet(isPresented: $showingAddContact) {
                AddContactView(contactItems: self.contactItems)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

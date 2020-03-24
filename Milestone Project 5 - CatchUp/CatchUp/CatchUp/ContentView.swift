//
//  ContentView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 17/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var contacts = Contacts()
    
    @State private var showingAddContact = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts.contacts) { contact in
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 18, height: 18)
                            contact.image
                                .frame(width: 18, height: 18)
                        }
                        Text(contact.name)
                            .font(.headline)
                    }
                }
            }
            .navigationBarTitle("CatchUp")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddContact = true
            }){
                HStack {
                    Image(systemName: "plus")
                    Text("Add")
                }
            })
            .sheet(isPresented: $showingAddContact) {
                AddContactView(contacts: self.contacts)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

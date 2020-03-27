//
//  AddContactView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 24/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var contacts: Contacts
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var name = ""
    
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                HStack(alignment: .center) {
                    Spacer()
                        .frame(width: 128)
                    ZStack {
                        Circle()
                            .fill(Color.secondary)
                            .frame(width: 128, height: 128)
                        if image != nil {
                            image?
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image(systemName: "person")
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .onTapGesture {
                        self.showImagePicker = true
                    }
                }
                Section(header: Text("Name of the Contact")) {
                    TextField("John Appleseed", text: $name)
                }
            }
            .navigationBarTitle("Add Contact")
            .navigationBarItems(trailing: Button(action: {
                let newContact = Contact(name: "John Appleseed", image: Image("Person"))
                self.contacts.contacts.append(newContact)
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Add Contact")
            })
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: self.$inputImage)
            }
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(contacts: Contacts())
    }
}

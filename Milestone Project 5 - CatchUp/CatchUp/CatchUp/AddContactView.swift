//
//  AddContactView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 01/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct AddContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var contactItems: Contacts
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.gray)
                        .opacity(0.50)
                        .frame(width: 128, height: 128)
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 128, height: 128)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                TextField("Enter contact name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            }
            .navigationBarTitle("Add Contact")
            .navigationBarItems(trailing:
                Button(action: {
                    guard let inputImage = self.inputImage else { return }
                    let contact = Contact(name: self.name, image: inputImage)
                    self.contactItems.contacts.append(contact)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            )
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(contactItems: Contacts())
    }
}

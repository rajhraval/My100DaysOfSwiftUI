//
//  AddContactView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 01/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import MapKit

struct AddContactView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var contactItems: Contacts
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var location = MKPointAnnotation()
    @State private var latitude: CLLocationDegrees = 0.0
    @State private var longitude: CLLocationDegrees = 0.0
    
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
                Text("Contact Name")
                TextField("Enter contact name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                    .frame(height: 18)
                Text("You met at")
                ZStack {
                    MapView(centerCoordinate: $centerCoordinate, annotation: location)
                        .frame(height: 300)
                    Circle()
                        .fill(Color.blue)
                        .opacity(0.3)
                        .frame(width: 18, height: 18)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                self.location.coordinate = self.centerCoordinate
                                self.latitude = self.location.coordinate.latitude
                                self.longitude = self.location.coordinate.longitude
                            }) {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(Color.yellow.opacity(50))
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding([.trailing])
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Add Contact")
            .navigationBarItems(trailing:
                Button(action: {
                    guard let inputImage = self.inputImage else { return }
                    let contact = Contact(name: self.name, image: inputImage, latitude: self.latitude, longitude: self.longitude)
                    self.contactItems.add(contact)
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

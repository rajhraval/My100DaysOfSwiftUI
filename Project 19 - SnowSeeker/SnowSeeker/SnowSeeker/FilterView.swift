//
//  FilterView.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 08/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct FilterView: View {
        
    @Environment(\.presentationMode) var presentationMode
    
    @State private var country = 0
    @State private var size = 0
    @State private var price = 0
    
    private let countries = ["Austria", "Canada", "France", "Italy", "United States"]
    private let sizes = ["All", "Small", "Medium", "Large"]
    private let prices = ["All", "$", "$$", "$$$"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Country")) {
                    Picker("Select a Country", selection: $country) {
                        ForEach(0..<countries.count) {
                            Text(self.countries[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Size")) {
                    Picker("Select Resort Size", selection: $size) {
                        ForEach(0..<sizes.count) {
                            Text(self.sizes[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Price")) {
                    Picker("Select Price", selection: $price) {
                        ForEach(0..<prices.count) {
                            Text(self.prices[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Filter By")
            .navigationBarItems(trailing: Button("Apply Filter") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}

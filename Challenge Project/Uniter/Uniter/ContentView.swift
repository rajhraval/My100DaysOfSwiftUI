//
//  ContentView.swift
//  Uniter
//
//  Created by RAJ RAVAL on 11/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = ""
    
    @State private var mainConverterValue = 0
    @State private var inputSegmentedValue = 0
    @State private var outputSegmentedValue = 0
    
    let length: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    let lengthValues = ["Meters", "Kilometers", "Feet", "Yard", "Miles"]
    
    var outputValue: Double {
        guard let value = Double(inputValue) else {
            return 0
        }
        let initial = Measurement(value: value, unit: length[inputSegmentedValue])
        return initial.converted(to: length[outputSegmentedValue]).value
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Input", text: $inputValue)
                }
                Section(header: Text("Input Value in")) {
                    Picker("Input", selection: $inputSegmentedValue) {
                        ForEach(0 ..< lengthValues.count) {
                            Text("\(self.lengthValues[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output Value in")) {
                    Picker("Output", selection: $outputSegmentedValue) {
                        ForEach(0 ..< lengthValues.count) {
                            Text("\(self.lengthValues[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output")) {
                    Text("\(outputValue)")
                }
            }
        .navigationBarTitle("Uniter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Unit Converter
//
//  Created by RAJ RAVAL on 19/01/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let unitDict = ["Meters": UnitLength.meters, "Kilometers": UnitLength.kilometers, "Feet": UnitLength.feet, "Yards": UnitLength.yards, "Miles": UnitLength.miles]
    
    var outputValue: Measurement<UnitLength> {
        let input = Double(inputValue) ?? 0
        let inputUnitValue = Measurement(value: input, unit: unitDict[units[inputUnit]]!)
        let outputUnitValue = inputUnitValue.converted(to: unitDict[units[outputUnit]]!)
        return outputUnitValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Enter the input value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Choose the input unit")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Choose the output unit")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Text("\(outputValue.value, specifier: "%.2f")")
                }
            
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by RAJ RAVAL on 18/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderDetails.type) {
                        ForEach(0..<OrderDetails.types.count, id: \.self) {
                            Text(OrderDetails.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.orderDetails.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderDetails.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderDetails.specialRequestEnabled.animation()) {
                        Text("Any Special Requests?")
                    }
                    
                    if order.orderDetails.specialRequestEnabled {
                        Toggle(isOn: $order.orderDetails.extraFrosting) {
                            Text("Add Extra Frosting")
                        }
                        
                        Toggle(isOn: $order.orderDetails.addSprinkles) {
                            Text("Add Sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
                
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by RAJ RAVAL on 19/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your Total is $\(self.order.orderDetails.cost, specifier: "%.2f")")
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        
        guard let encoded = try? JSONEncoder().encode(order.orderDetails) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.confirmationTitle = "No Internet Connection!"
                self.confirmationMessage = "Please connect to the internet to place the order."
                self.showingConfirmation = true
                print("No Data in response: \(error?.localizedDescription ?? "Unknown Error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderDetails.self, from: data) {
                self.confirmationTitle = "Thank You!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(OrderDetails.types[decodedOrder.type]) cupcakes is on it's way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from Server.")
            }
            
        }.resume()
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

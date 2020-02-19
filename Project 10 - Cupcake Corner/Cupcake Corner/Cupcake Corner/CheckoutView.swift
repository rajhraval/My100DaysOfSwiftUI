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
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your Total is $\(self.order.cost, specifier: "%.2f")")
                    
                    Button("Place Order") {
                        
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check Out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}

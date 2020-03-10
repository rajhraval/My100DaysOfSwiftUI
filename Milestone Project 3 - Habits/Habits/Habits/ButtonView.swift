//
//  ButtonView.swift
//  Habits
//
//  Created by RAJ RAVAL on 10/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    
    let text: String
    let color: UIColor
    
    var body: some View {
        ZStack {
            Color(color)
                .frame(width: 366, height: 56)
                .cornerRadius(8)
            Text(text)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Increment Habit Count", color: .black)
    }
}

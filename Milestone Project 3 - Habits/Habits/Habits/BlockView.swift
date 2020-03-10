//
//  BlockView.swift
//  Habits
//
//  Created by RAJ RAVAL on 10/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct BlockView: View {
    
    let category: String
    let title: String
    let color: UIColor
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                Color(color)
                    .frame(width: 366, height: 113)
                    .cornerRadius(13)
                HStack {
                    Spacer()
                        .frame(width: 23)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(category)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                        Text(title)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(category: "Health", title: "Eat eggs even on Sunday or Monday!", color: .red)
    }
}

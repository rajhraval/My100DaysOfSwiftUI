//
//  ContentView.swift
//  Moonshot
//
//  Created by RAJ RAVAL on 08/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct LargeCard: View {
    
    var headingText: String
    var bodyText: String
    var color: UIColor
    
    var body: some View {
        ZStack {
            Color(color).frame(width: 342, height: 182)
                .cornerRadius(6)
            HStack {
                Spacer()
                    .frame(width: 24)
                VStack(alignment: .leading) {
                    Text(headingText)
                        .foregroundColor(.white)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(bodyText)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .opacity(0.8)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                    .frame(width: 95)
            }
        }
    }
}

struct VerticalCard: View {
    
    var headingText: String
    var bodyText: String
    var color: UIColor
    
    var body: some View {
        ZStack {
            Color(color).frame(width: 159, height: 183)
                .cornerRadius(6)
            HStack {
                Spacer()
                    .frame(width: 18)
                VStack(alignment: .leading) {
                    Text(headingText)
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(bodyText)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .opacity(0.8)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                    .frame(width: 30)
            }
        }
    }
}

//Button("Decode JSON") {
//    let input = """
//    {
//        "name": "Taylor Swift",
//        "address": {
//            "street": "555, Taylor Swift Avenue",
//            "city": "Nashville"
//        }
//    }
//    """
//
//    struct User: Codable {
//        var name: String
//        var address: Address
//    }
//
//    struct Address: Codable {
//        var street: String
//        var city: String
//    }
//
//    let data = Data(input.utf8)
//    let decoder = JSONDecoder()
//    if let user = try? decoder.decode(User.self, from: data) {
//        print(user.address.street)
//    }
//
//}

struct ContentView: View {
    
    let customPurple = UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0)
    let customBlue = UIColor(red:0.00, green:0.55, blue:1.00, alpha:1.0)
    let customGreen = UIColor(red:0.06, green:0.89, blue:0.00, alpha:1.0)
    let customSkyBlue = UIColor(red:0.00, green:0.84, blue:1.00, alpha:1.0)
    let customPink = UIColor(red:1.00, green:0.40, blue:0.61, alpha:1.0)
    let customOrange = UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0)
    let customIndigo = UIColor(red:0.42, green:0.27, blue:1.00, alpha:1.0)
    let customMaroon = UIColor(red:1.00, green:0.00, blue:0.45, alpha:1.0)
    
    let bigCards = [
        LargeCard(headingText: "Music", bodyText: "Enjoy the brand new playlists", color: UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0)),
        LargeCard(headingText: "Podcasts", bodyText: "Enjoy the brand new podcasts", color: UIColor(red:0.00, green:0.55, blue:1.00, alpha:1.0)),
        LargeCard(headingText: "Games", bodyText: "Enjoy the brand new games", color: UIColor(red:1.00, green:0.40, blue:0.61, alpha:1.0)),
        LargeCard(headingText: "Books", bodyText: "Enjoy the brand new games", color: UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0))
    ]
    let verticalCards = [
        VerticalCard(headingText: "Top 10", bodyText: "Games to Play", color: UIColor(red:0.06, green:0.89, blue:0.00, alpha:1.0)),
        VerticalCard(headingText: "Top 10", bodyText: "Books to Read", color: UIColor(red:0.00, green:0.84, blue:1.00, alpha:1.0)),
        VerticalCard(headingText: "Top 10", bodyText: "Games to Play", color: UIColor(red:0.42, green:0.27, blue:1.00, alpha:1.0)),
        VerticalCard(headingText: "Top 10", bodyText: "Books to Read", color: UIColor(red:1.00, green:0.00, blue:0.45, alpha:1.0))
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            Spacer()
                .frame(height: 24)
            VStack(spacing: 24) {
                LargeCard(headingText: "Music", bodyText: "Enjoy the brand new playlists", color: UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0))
                LargeCard(headingText: "Podcasts", bodyText: "Enjoy the brand new podcasts", color: UIColor(red:0.00, green:0.55, blue:1.00, alpha:1.0))
                HStack {
                    Spacer()
                        .frame(width: 24)
                    ScrollView(.horizontal) {
                        HStack(spacing: 24) {
                            VerticalCard(headingText: "Top 10", bodyText: "Games to Play", color: UIColor(red:0.06, green:0.89, blue:0.00, alpha:1.0))
                            VerticalCard(headingText: "Top 10", bodyText: "Books to Read", color: UIColor(red:0.00, green:0.84, blue:1.00, alpha:1.0))
                            VerticalCard(headingText: "Top 10", bodyText: "Games to Play", color: UIColor(red:0.42, green:0.27, blue:1.00, alpha:1.0))
                            VerticalCard(headingText: "Top 10", bodyText: "Books to Read", color: UIColor(red:1.00, green:0.00, blue:0.45, alpha:1.0))
                        }
                    }
                    Spacer()
                        .frame(width: 24)
                }
                LargeCard(headingText: "Music", bodyText: "Enjoy the brand new playlists", color: UIColor(red:1.00, green:0.40, blue:0.61, alpha:1.0))
                LargeCard(headingText: "Podcasts", bodyText: "Enjoy the brand new podcasts", color: UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0))

            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

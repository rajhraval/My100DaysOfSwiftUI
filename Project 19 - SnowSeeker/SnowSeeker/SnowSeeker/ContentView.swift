//
//  ContentView.swift
//  SnowSeeker
//
//  Created by RAJ RAVAL on 05/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

enum SortType {
    case none, alphabetically_ascending, alphabetically_descending, country
}

struct ContentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var favorites = Favorites()
    
    @State private var showSortingSheet = false
    @State private var showFilterViewSheet = false
    @State private var sortOption: SortType = .none
    @State private var country = 0
    @State private var size = 0
    @State private var price = 0
    
    private let countries = ["Austria", "Canada", "France", "Italy", "United States"]
    private let sizes = ["All", "Small", "Medium", "Large"]
    private let prices = ["All", "$", "$$", "$$$"]
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var sortedResorts: [Resort] {
        
        switch sortOption {
        case .country:
            return resorts.sorted { $0.country > $1.country }
        case .alphabetically_descending:
            return resorts.sorted { $0.name > $1.name }
        case .alphabetically_ascending:
            return resorts.sorted { $0.name < $1.name }
        default:
            return resorts
        }
        
        switch countries.count {
        case 0:
            return resorts.filter { $0.country == "Austria" }
        case 1:
            return resorts.filter { $0.country == "Canada" }
        case 2:
            return resorts.filter { $0.country == "France" }
        case 3:
            return resorts.filter { $0.country == "Italy" }
        default:
            return resorts.filter { $0.country == "United States" }
        }
        
        
    }
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 25)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: {
                self.showSortingSheet = true
                print("Sorting")
            }){
               Image(systemName: "arrow.up.arrow.down.square")
               Text("Sort")
            }, trailing: Button(action: {
                self.showFilterViewSheet = true
                  print("Filtering")
            }){
                Image(systemName: "line.horizontal.3.decrease.circle")
                Text("Filter")
            })
            WelcomeView()
        }
        .environmentObject(favorites)
        .actionSheet(isPresented: $showSortingSheet) {
            ActionSheet(title: Text("Sort"), message: Text("Sort resorts according to"), buttons: [
                .default(Text("Alphabetically (A-Z)")) { self.sortOption = .alphabetically_ascending },
                .default(Text("Alphabetically (Z-A)")) { self.sortOption = .alphabetically_descending },
                .default(Text("Country")) { self.sortOption = .country },
                .default(Text("None")) { self.sortOption = .none },
                .cancel()
            ])
        }
        .sheet(isPresented: $showFilterViewSheet) {
            NavigationView {
                Form {
                    Section(header: Text("Country")) {
                        Picker("Select a Country", selection: self.$country) {
                            ForEach(0..<self.countries.count) {
                                Text(self.countries[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Size")) {
                        Picker("Select Resort Size", selection: self.$size) {
                            ForEach(0..<self.sizes.count) {
                                Text(self.sizes[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Price")) {
                        Picker("Select Price", selection: self.$price) {
                            ForEach(0..<self.prices.count) {
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
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

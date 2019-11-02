//
//  ContentView.swift
//  iExpense
//
//  Created by RAJ RAVAL on 29/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    func changeTextColor(amount: Int) -> Text {
        switch amount {
        case 1...10:
            return Text("$\(amount)")
                .foregroundColor(Color.purple)
        case 11...100:
            return Text("$\(amount)")
                .foregroundColor(Color.blue)
        case 101...1000:
            return Text("$\(amount)")
                .foregroundColor(Color.green)
        case 1001...10000:
            return Text("$\(amount)")
                .foregroundColor(Color.yellow)
        default:
            return Text("$\(amount)")
                .foregroundColor(Color.red)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {
                    item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        self.changeTextColor(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    self.showingAddExpense = true
                }){
                    Image(systemName: "plus")
                }
                EditButton()
            })
            .navigationBarTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

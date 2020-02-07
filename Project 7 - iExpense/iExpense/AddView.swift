//
//  AddView.swift
//  iExpense
//
//  Created by RAJ RAVAL on 06/02/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(AddView.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                    if let actualAmount = Int(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    } else if self.amount.isEmpty && self.name.isEmpty {
                        self.showError(errorTitle: "Empty Fields", errorMessage: "Enter the expense name and the expense amount.")
                    } else {
                        self.showError(errorTitle: "Invalid Amount", errorMessage: "Enter a valid expense amount in numbrs.")
                    }
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func showError(errorTitle: String, errorMessage: String) {
        showingAlert = true
        alertTitle = errorTitle
        alertMessage = errorMessage
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

//
//  SettingsView.swift
//  Flashzilla
//
//  Created by RAJ RAVAL on 31/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var enableSetting = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $enableSetting) {
                    Text("Allow Card to reappear, if the answer went wrong")
                }
                .padding()
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

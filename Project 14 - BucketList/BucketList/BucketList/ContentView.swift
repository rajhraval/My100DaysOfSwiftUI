//
//  ContentView.swift
//  BucketList
//
//  Created by RAJ RAVAL on 08/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    @State private var showErrorAlert = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            if isUnlocked {
                SecuredMapView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
    }
    
   
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.errorTitle = "Unlocked Failed"
                        self.errorMessage = "\(error?.localizedDescription ?? "Unknown Error")"
                        self.showErrorAlert = true
                    }
                }
            }
        } else {
            self.errorTitle = "Unlocked Failed"
            self.errorMessage = "No Biometrics Available"
            self.showErrorAlert = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

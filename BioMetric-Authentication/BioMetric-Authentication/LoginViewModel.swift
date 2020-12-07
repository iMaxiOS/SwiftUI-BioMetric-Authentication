//
//  LoginViewModel.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI
import LocalAuthentication
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var alert = false
    @Published var alertMessage = ""
    @Published var store_info = false
    
    @AppStorage("status") var logged = false
    @AppStorage("stored_User") var Stored_User = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        
        if email == Stored_User && scanner.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: .none
        ) {
            return true
        }
        return false
    }
    
    func authUser() {
        let scanner = LAContext()
        
        scanner.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "To Unlock \(email)"
        ) { (status, error) in
            if error != nil {
                print("🍎🍎🍎\(error!.localizedDescription)")
                return
            }
        }
    }
    
    func verifyUser() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.alert.toggle()
            }
            
            if self.Stored_User == "" || self.Stored_Password == "" {
                self.store_info.toggle()
                return
            }
            
            withAnimation{
                self.logged = true
            }
        }
    }
}

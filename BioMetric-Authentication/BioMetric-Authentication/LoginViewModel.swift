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
    @Published var isLoading = false
    @Published var store_info = false
    
    @AppStorage("status") var logged = false
    @AppStorage("stored_User") var stored_User = ""
    @AppStorage("stored_Password") var stored_Password = ""
    
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        
        if email == stored_User && scanner.canEvaluatePolicy(
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
            
            DispatchQueue.main.async {
                self.password = self.stored_Password
                self.verifyUser()
            }
        }
    }
    
    func verifyUser() {
        
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            self.isLoading = false
            
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.alert.toggle()
                return
            }
            
            if self.stored_User == "" || self.stored_Password == "" {
                self.store_info.toggle()
                return
            }
            
            withAnimation{
                self.logged = true
            }
        }
    }
}

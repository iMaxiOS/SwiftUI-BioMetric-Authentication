//
//  LoginViewModel.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI
import LocalAuthentication

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var alert = false
    @Published var alertMessage = ""
    
    @AppStorage("status") var logged = false
    @AppStorage("stored_User") var Stored_User = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    
    func getBioMetricStatus() -> Bool{
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
}

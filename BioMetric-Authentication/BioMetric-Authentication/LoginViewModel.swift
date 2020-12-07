//
//  LoginViewModel.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var alert = false
    @Published var alertMessage = ""
    
}

//
//  ContentView.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @AppStorage("status") var logged = false
    
    var body: some View {
        if logged {
            TabBarView()
                .navigationBarHidden(true)
                .preferredColorScheme(.light)
        } else {
            Login()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

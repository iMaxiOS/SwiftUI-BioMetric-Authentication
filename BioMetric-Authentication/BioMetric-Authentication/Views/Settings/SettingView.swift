//
//  SettingView.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 08.12.2020.
//

import SwiftUI
import Firebase

struct SettingView: View {
    
    @AppStorage("status") var logged = false
    
    var body: some View {
        
        VStack(spacing: 15) {
            Text(Auth.auth().currentUser?.email ?? "")
            Text(Auth.auth().currentUser?.uid ?? "")
            
            Button(action: {
                try! Auth.auth().signOut()
                
                withAnimation {
                    self.logged = false
                }
            }, label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            })
        }
    }
}

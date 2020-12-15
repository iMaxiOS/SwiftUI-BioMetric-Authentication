//
//  NotificationView.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 15.12.2020.
//

import SwiftUI

struct NotificationView: View {
    
    @State private var isNotification = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $isNotification, label: {
                Text("Notification")
            })
            .padding(.top, 40)
            .padding()
            
            Spacer(minLength: 0)
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

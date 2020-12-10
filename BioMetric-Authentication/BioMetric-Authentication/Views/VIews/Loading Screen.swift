//
//  Loading Screen.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI

struct Loading_Screen: View {
    
    @State var animation = false
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea(.all, edges: .all)
            
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color("green"), lineWidth: 10)
                .frame(width: 60, height: 60)
                .rotationEffect(.init(degrees: animation ? 360 : 0.0))
                .padding()
                .background(Color.white)
                .cornerRadius(15)
        }
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                animation.toggle()
            }
        })
    }
}

//
//  Home.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI
import Firebase

struct Home: View {
    
    @State var items = [
        Item(title: "Besom Lemon Juice", price: "$25.99", discont: "7%", image: "p1"),
        Item(title: "Besom Pine Juice", price: "$15.99", discont: "25%", image: "p2"),
        Item(title: "Besom Orange Juice", price: "$20.99", discont: "10%", image: "p3"),
    ]
    
    @ObservedObject var tabData : TabViewModel
    var animation: Namespace.ID
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "bag")
                            .font(.system(size: 24, weight: .heavy))
                            .foregroundColor(.primary)
                    }
                }
                
                Text("Besom")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
            }
            .padding()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(items){item in
                        Card(item: item, tabData: tabData,animation: animation)
                    }
                }
                .padding()
            }
        }
    }
}

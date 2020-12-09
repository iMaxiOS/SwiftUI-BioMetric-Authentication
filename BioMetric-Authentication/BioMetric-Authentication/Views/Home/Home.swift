//
//  Home.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI
import Firebase

struct Home: View {
    
    var animation: Namespace.ID
    @ObservedObject var tabData: TabViewModel
    
    @State var items = [
        Item(title: "Beson Limon Juice", price: "$15.44", discont: "7%", image: "p1"),
        Item(title: "Beson Pine Juice", price: "$25.00", discont: "10%", image: "p2"),
        Item(title: "Beson Orange Juice", price: "$35.80", discont: "15%", image: "p3")
    ]
        
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            ForEach(items) { item in
                Card(item: item, tabData: tabData, animation: animation)
            }
        })
        .padding(.horizontal)
    }
}

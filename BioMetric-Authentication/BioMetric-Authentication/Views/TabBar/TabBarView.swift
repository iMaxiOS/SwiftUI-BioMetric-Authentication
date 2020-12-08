//
//  TabBarView.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 08.12.2020.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
         
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            Text("Like")
                .tabItem {
                    Image(systemName: "suit.heart.fill")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}
//
//  TabBarView.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 08.12.2020.
//

import SwiftUI

struct TabBarView: View {
    
    @Namespace var animation
    @StateObject var tabData = TabViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                Home(tabData: tabData, animation: animation)
                    .tabItem { Image(systemName: "house.fill") }
                Search()
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .navigationBarHidden(true)
                Weather()
                    .tabItem { Image(systemName: "thermometer.sun.fill") }
                SettingView()
                    .tabItem { Image(systemName: "person.fill") }
            }
            
            if tabData.isDetail {
                Detail(tabData: tabData, animation: animation)
            }
        }
    }
}

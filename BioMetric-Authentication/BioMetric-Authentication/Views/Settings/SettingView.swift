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
    
    @State private var isPresent = false
    
    @State private var settings = [
        SettingModel(id: 0, image: "1", title: "Account"),
        SettingModel(id: 1, image: "2", title: "Notification"),
        SettingModel(id: 2, image: "3", title: "Privacy"),
        SettingModel(id: 3, image: "4", title: "Help Center"),
        SettingModel(id: 4, image: "5", title: "General"),
        SettingModel(id: 5, image: "6", title: "About Us"),
        SettingModel(id: 6, image: "7", title: "Log out")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(settings, id: \.self) { i in
                    Button {
                        switch i.id {
                        case 0:
                            self.isPresent.toggle()
                        case 6:
                            try! Auth.auth().signOut()

                            withAnimation {
                                self.logged = false
                            }
                        default:
                            break
                        }
                    } label: {
                        HStack {
                            Image(i.image)
                                .resizable()
                                .clipped()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.vertical, 10)
                            
                            Text(verbatim: i.title)
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                            
                            Spacer(minLength: 15)
                            
                            Image(systemName: "chevron.forward")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 15, alignment: .center)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $isPresent, content: {
                        AccountView()
                    })
                }
            }
        }
        .padding()
    }
}

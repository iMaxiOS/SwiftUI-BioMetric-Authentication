//
//  Login.swift
//  BioMetric-Authentication
//
//  Created by Maxim Granchenko on 07.12.2020.
//

import SwiftUI
import LocalAuthentication

struct Login: View {
    
    @AppStorage("status") var logged = false
    @AppStorage("stored_User") var Stored_User = ""
    @AppStorage("stored_Password") var Stored_Password = ""
    
    @State var startAnimation = false
    
    @StateObject var loginModel = LoginViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Spacer(minLength: 0)
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 35)
                    .padding()
                
                HStack {
                    VStack(alignment: .leading, spacing: 12, content: {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Plaese sign in to continue")
                            .foregroundColor(Color.white.opacity(0.5))
                            .fontWeight(.regular)
                    })
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.horizontal, 15)
                
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(width: 35)
                    
                    TextField("EMAIL", text: $loginModel.email)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(loginModel.email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(width: 35)
                    
                    SecureField("PASSWORD", text: $loginModel.password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(loginModel.password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15) {
                    Button(action: loginModel.verifyUser, label: {
                        Text("LOGIN")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width  - 150)
                            .background(Color("green"))
                            .clipShape(Capsule())
                    })
                    .opacity(loginModel.email != "" && loginModel.password != "" ? 1 : 0.5)
                    .disabled(loginModel.email != "" && loginModel.password != "" ? false : true)
                    .alert(isPresented: $loginModel.alert, content: {
                        Alert(
                            title: Text("Error"),
                            message: Text(loginModel.alertMessage),
                            dismissButton: .destructive(Text("Ok"))
                        )
                    })
                    
                    if loginModel.getBioMetricStatus() {
                        Button(action: loginModel.authUser, label: {
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color("green"))
                                .clipShape(Circle())
                        })
                    }
                }
                .padding(.top)
                
                Button(action: {}, label: {
                    Text("Forger password?")
                        .foregroundColor(Color("green"))
                })
                .padding(.top, 8)
                .alert(isPresented: $loginModel.store_info, content: {
                    Alert(
                        title: Text("Message"),
                        message: Text("Store Information For Future Login Using BioMetric Authentication ???"),
                        primaryButton: .default(Text("Accept"), action: {
                            
                            Stored_User = loginModel.email
                            Stored_Password = loginModel.password
                            
                            withAnimation{self.logged = true}
                            
                        }), secondaryButton: .cancel({
                            withAnimation{self.logged = true}
                        })
                    )
                })
                
                Spacer(minLength: 0)
                
                HStack(spacing: 5, content: {
                    Button(action: {}, label: {
                        Text("Don`n have an account? ")
                            .foregroundColor(Color.white.opacity(0.6))
                    })
                    
                    Button(action: {}, label: {
                        Text("Sign up")
                            .foregroundColor(Color("green"))
                    })
                })
                .padding(.vertical)
                
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .all))
            .animation(startAnimation ? .easeOut : .none)
            
            if loginModel.isLoading {
                Loading_Screen()
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.startAnimation.toggle()
            }
        })
    }
}

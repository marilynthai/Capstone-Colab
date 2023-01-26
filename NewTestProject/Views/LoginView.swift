//
//  LoginView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// 

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .opacity(0.25)
                    .ignoresSafeArea()
                VStack {
                    Text("TBD App Name")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(wrongEmail))
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(wrongPassword))
                    
                    
                    Button("Login") {
                        login()
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You have successfully logged in!"), isActive: $showingLoginScreen) {
                        EmptyView()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    //    func authenticateUser(username: String, password: String) {
    //        if username.lowercased() == "nina" {
    //            wrongUsername = 0
    //            if password.lowercased() == "abc123" {
    //                wrongPassword = 0
    //                showingLoginScreen = true
    //            } else {
    //                wrongPassword = 2
    //            }
    //        } else {
    //            wrongUsername = 2
    //            }
    //        }
    //    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result , error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                wrongPassword = 0
                showingLoginScreen = true
                
            }
        }
    }
        
        struct LoginView_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
            
        }
    }


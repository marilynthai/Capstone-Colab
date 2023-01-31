//
//  HomeView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// 

import SwiftUI

struct HomeView: View {
    // create state variables for username and password
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @EnvironmentObject var loginManager:LoginManager
    @EnvironmentObject var dataManager:DataManager
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue
                    .opacity(0.25)
                    .ignoresSafeArea()
                VStack {
                    if loginManager.isLoggedIn {
                        AllPostsView().environmentObject(DataManager())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(.move(edge: .leading))
                    } else {
                        LoginView(loginManager: loginManager)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(.move(edge: .leading))
                    }
                    
                }
                
            }
            
        }
    }
}
    
    //        NavigationView {
    //            ZStack {
    //                Color.blue
    //                    .opacity(0.25)
    //                    .ignoresSafeArea()
    //                VStack {
    //                    Text("TBD App Name")
    //                        .font(.largeTitle)
    //                        .bold()
    //                        .padding()
    //
    //
    //                    NavigationLink(destination: LoginView()) {
    //                        Text("Login")
    //                    }
    //                    .foregroundColor(.black)
    //                    .frame(width:300, height:50)
    //                    .background(Color.white)
    //                    .cornerRadius(10)
    //
    //                    NavigationLink(destination: CreateAUserView()) {
    //                        Text("Sign Up")
    //                    }
    //                    .foregroundColor(.black)
    //                    .frame(width:300, height:50)
    //                    .background(Color.white)
    //                    .cornerRadius(10)
    //
    //                    NavigationLink(destination: Text("You have successfully logged in!"), isActive: $showingLoginScreen) {
    //                        EmptyView()
    //                    }
    //                }
    //            }
    //            .navigationBarHidden(true)
    
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
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(DataManager())
                . environmentObject(LoginManager())
        }
    }
    


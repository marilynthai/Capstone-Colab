//
//  HomeView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// 

import SwiftUI

extension Font {
    static func system(
        size: CGFloat,
        weight: UIFont.Weight,
        width: UIFont.Width) -> Font {
        return Font(
            UIFont.systemFont(
                ofSize: size,
                weight: weight,
                width: width)
        )
    }
}

struct HomeView: View {
    // create state variables for username and password
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var loginManager:LoginManager
    @EnvironmentObject var dataManager:DataManager
    

    
    var body: some View {
        NavigationView{
            ZStack {
                    if loginManager.isLoggedIn {
                        AllPostsView().environmentObject(DataManager())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(.move(edge: .leading))
                    } else if loginManager.isLoggedIn == false {
                        TabView()
                        {
                            LoginView()
                                .tabItem {
                                    Label("Login", systemImage: "person.fill")
                                }.tag(1)
                            
                            CreateAUserView()
                            
                                .tabItem {
                                    Label("Create User", systemImage: "person.fill.badge.plus")
                                }.tag(2)
                            
                        }
                        .accentColor(Color("Accent"))
                        
                    }
            }
        }
    }
    
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(DataManager())
                . environmentObject(LoginManager())
        }
    }
    
    
}

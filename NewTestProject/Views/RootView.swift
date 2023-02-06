//
//  HomeView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
// Marilyn

import SwiftUI
import Firebase

extension Binding {
    func onUpdate(_ closure: @escaping () -> Void) -> Binding<Value> {
        Binding(get: {
            wrappedValue
        }, set: { newValue in
            wrappedValue = newValue
            closure()
        })
    }
}

struct AllPostsView: View {
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    @State private var showAdd = false
    @State private var search = ""
    @State var selectedTab = 1
    
    var handler: Binding<Int> { Binding(
        get: { self.selectedTab },
        set: {
            if $0 == self.selectedTab {
                dataManager.fetchPosts()
                dataManager.fetchUserPosts()
                dataManager.fetchUserClaims()

            }
            self.selectedTab = $0
        }
    )}

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if loginManager.isLoggedIn {
                TabView(selection: handler)
                {
                    TestAllPostView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }.tag(1)
                        .toolbarBackground(Color.white, for: .tabBar)
                    
                    ClaimsView()
                    
                        .tabItem {
                            Label("My Claims", systemImage: "heart")
                        }.tag(2)
                        .toolbarBackground(Color.white, for: .tabBar)
                    MyPostsView()
                        .tabItem {
                            Label("My Posts", systemImage: "list.dash")
                        }.tag(3)
                        .toolbarBackground(Color.white, for: .tabBar)
                    
                    CreatePostView()
                        .tabItem {
                            Label("Create Post", systemImage: "plus.circle.fill")
                        }.tag(4)
                        .toolbarBackground(Color.white, for: .tabBar)
                    
                    
                }
                .accentColor(.red)

                
                Button {
                    loginManager.logout()
                } label: {
                    Text("Log Out")
                }
                .font(.system(.headline, design: .rounded))
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
                .padding()
                
            } else {
                HomeView()
            }
        }
    }
        }

struct AllPostsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPostsView()
            .environmentObject(DataManager())
            .environmentObject(LoginManager())
    }
}

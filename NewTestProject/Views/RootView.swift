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
    
    
    //change the tabview background color
    init() {
      UITabBar.appearance().backgroundColor = UIColor(Color("Neutral"))
    }

    
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
                        }
                        .tag(1)

                    
                    ClaimsView()
                    
                        .tabItem {
                            Label("My Claims", systemImage: "heart")
                        }.tag(2)
                    MyPostsView()
                        .tabItem {
                            Label("My Posts", systemImage: "list.dash")
                        }.tag(3)
                    
                    CreatePostView()
                        .tabItem {
                            Label("Create Post", systemImage: "plus.circle.fill")
                        }.tag(4)
                    
                    MyUserView()
                        .tabItem{
                            Label("My Profile", systemImage: "person.circle.fill")
                        }.tag(5)
                }
                
                .accentColor(Color("Accent"))
                
                
//                Button {
//                    loginManager.logout()
//                } label: {
//                    Text("Log Out")
//                }
//                .font(.system(.headline, design: .rounded))
//                .padding()
//                .foregroundColor(.black)
//                .background(Color("Accent"))
//                .cornerRadius(10)
//                .padding()
                
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

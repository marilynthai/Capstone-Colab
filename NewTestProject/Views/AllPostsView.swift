//
//  HomeView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
// Marilyn

import SwiftUI
import Firebase

struct AllPostsView: View {
    @EnvironmentObject var dataManager:DataManager
    @StateObject var loginManager = LoginManager()
    @State private var showAdd = false
    @State private var search = ""
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
                if loginManager.isLoggedIn {
                    
                    TabView {
                        TestAllPostView()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                        
                        ClaimsView()
                        
                            .tabItem {
                                Label("My Claims", systemImage: "heart")
                            }
                        MyPostsView()
                            .tabItem {
                                Label("My Posts", systemImage: "list.dash")
                            }
                        
                        CreatePostView()
                            .tabItem {
                                Label("Create Post", systemImage: "plus.circle.fill")
                            }
                        
                        
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
                    LoginView(loginManager: loginManager)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
        }
    }

        
//        NavigationView {
//            VStack{
//
//                TextField("Search",text:$search)
//                    .padding()
//                    .padding()
//                    .frame(width:300, height:50)
//                    .background(Color.white.opacity(0.75))
//                    .cornerRadius(10)
//                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//
//                List(dataManager.posts, id:\.id) { post in
//                    NavigationLink {
//                        SinglePostView()
//                    } label: {
//                        HStack {
//                        Image(systemName:"photo.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 70)
//                            .cornerRadius(4)
//
//                        VStack(alignment: .leading){
//                            Text(post.name)
//                                .fontWeight(.bold)
//
//                            Text(post.description)
//                                .font(.subheadline)
//                        }
//                        }
//                    }
//
//                }
//
//                .navigationTitle("Posts")
////                 adding a post with + button
//                            .navigationBarItems(trailing:Button(action:{
//                                showAdd.toggle()
//                            },label: {
//                                Image(systemName:"plus")
//                            }))
//                            .sheet(isPresented: $showAdd){
//                                CreatePostView()
//                            }
//                Button {
//                    loginManager.logout()
//                    // how do we get back to home page
//                } label: {
//                    Text("Log Out")
//                }
//                .foregroundColor(.black)
//                .frame(width:300, height:50)
//                .background(Color.white)
//                .cornerRadius(10)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
//                .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
//            }
        }

struct AllPostsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPostsView()
            .environmentObject(DataManager())
    }
}

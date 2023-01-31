//
//  MyPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// 

import SwiftUI
import Firebase

struct MyPostsView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showAdd = false
    
    
    var body: some View {
        
        ZStack{
            NavigationView {
                List(dataManager.userPosts, id:\.id) { post in
                    NavigationLink {
                        TestSinglePostView(post: post)
                    } label: {
                        HStack {
                            Image(systemName:"photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 70)
                                .cornerRadius(4)
                            
                            VStack(alignment: .leading){
                                Text(post.name)
                                    .fontWeight(.bold)
                                
                                Text(post.description)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .navigationTitle("My Posts")

            }
            
        }
        
    }
    //        TabView {
    //            AllPostsView()
    //                .tabItem(){
    //                    Text("All posts")
    //                }
    //            ClaimsView()
    //                .tabItem(){
    //                    Text("My Claims")
    //                }
    //            CreatePostView()
    //                .tabItem(){
    //                    Text("Create A Post")
    //
    //                }
    //            List(dataManager.posts, id:\.id) { post in
    //                    Text(post.name)
    //                }
    //
    //                .navigationBarItems(trailing:Button(action:{
    //                    showAdd.toggle()
    //                },label: {
    //                    Image(systemName:"plus")
    //                }))
    //                .sheet(isPresented: $showAdd){
    //                    CreatePostView()
    
}
    
    
    struct MyPostsView_Previews: PreviewProvider {
        static var previews: some View {
            MyPostsView()
                .environmentObject(DataManager())
        }
        
    }


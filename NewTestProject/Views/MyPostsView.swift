//
//  MyPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// 

import SwiftUI

struct MyPostView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showAdd = false
    
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Image(systemName:"photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                    .cornerRadius(4)
                
                VStack(alignment: .leading){
                    Text("Post title")
                        .fontWeight(.bold)

                    Text("Secondary test")
                        .font(.subheadline)
                }
        }
            .navigationTitle("My Posts")

        }
        
//        ZStack{
//            Color.blue.opacity(0.25)
//            Image(systemName: "person.circle")
//                .foregroundColor(Color.black)
//                .font(.system(size:80))
//        }
//        TabView {
//            AllPostsView()
//                .tabItem(){
//                    Text("All posts")
//                }
//            ClaimsView()
//                .tabItem(){
//                    Text("My Claims")
//                    }
//            CreatePostView()
//                .tabItem(){
//                    Text("Create A Post")
//
//        }
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
    }
    
    
    struct MyPostView_Previews: PreviewProvider {
        static var previews: some View {
            MyPostView()
                .environmentObject(DataManager())
    }
    
}


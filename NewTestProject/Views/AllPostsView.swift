//
//  HomeView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
// Marilyn

import SwiftUI

struct AllPostsView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showAdd = false
    @State private var search = ""

    
    
    var body: some View {
        NavigationView {
            
            VStack{
                TextField("Search",text:$search)
                    .padding()
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                List(dataManager.posts, id:\.id) { post in
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
                .navigationTitle("Posts")
//                 adding a post with + button
                            .navigationBarItems(trailing:Button(action:{
                                showAdd.toggle()
                            },label: {
                                Image(systemName:"plus")
                            }))
                            .sheet(isPresented: $showAdd){
                                CreatePostView()
                            }
            }
        }
    }
}

struct AllPostsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPostsView()
            .environmentObject(DataManager())
    }
}

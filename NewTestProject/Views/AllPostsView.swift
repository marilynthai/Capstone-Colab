//
//  HomeView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var showAdd = false
    
    
    var body: some View {
        NavigationView {
            List(dataManager.posts, id:\.id) { post in
                Text(post.name)
            }
            .navigationTitle("Posts")
            .navigationBarItems(trailing:Button(action:{
                showAdd.toggle()
            },label: {
                Image(systemName:"plus")
            }))
            .sheet(isPresented: $showAdd){
                NewPostView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

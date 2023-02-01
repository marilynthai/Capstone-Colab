//
//  NewPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// Marilyn

import SwiftUI
import Firebase


struct CreatePostView: View {
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    @State private var newPostName = ""
    @State private var newPostDescription = ""
//    @State private var newContactEmail = ""
    @State private var category = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue
                    .opacity(0.25)
                    .ignoresSafeArea()
                VStack {
                    Button {
                    } label: {
                        Text("Upload Image")
                    }
                    .foregroundColor(.black)
                    .frame(width:200, height:40)
                    .background(Color.white)
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading) {
                        Text("Name")
                        TextField("Post Name",text: $newPostName)
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                        TextField("Description",text: $newPostDescription)
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Contact Email")
                        Text(loginManager.userEmail)
                            .padding()
                            .frame(width:300, height:50)
                            .cornerRadius(10)
                    }
                    VStack(alignment: .leading) {
                        Text("Category")
                            .multilineTextAlignment(.leading)
                        TextField("Category",text: $category)
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                    }
                    Button {
                        dataManager.addPost(name: newPostName,description: newPostDescription,contactEmail: loginManager.userEmail,category: category)
                        newPostName = ""
                        newPostDescription = ""
//                        newContactEmail = ""
                        category = ""
                        dataManager.fetchPosts()
                        dataManager.fetchUserPosts()
                        
                    } label: {
                        Text("Save Post")
                    }
                    
                    .disabled(newPostName.isEmpty || newPostDescription.isEmpty || category.isEmpty)
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Create Post")
        }
    }
    
    struct CreatePostView_Previews: PreviewProvider {
        static var previews: some View {
            CreatePostView()
                .environmentObject(DataManager())
        }
    }
}

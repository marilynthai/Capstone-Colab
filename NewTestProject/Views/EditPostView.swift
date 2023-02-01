//
//  EditPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
//

import SwiftUI


struct EditPostView: View {
    @State var editPost:Post
    @EnvironmentObject var dataManager:DataManager
//    @State private var changePostName = ""
//    @State private var changePostDescription = ""
//    @State private var changeContactEmail = ""
//    @State private var changeCategory = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Button {
                    } label: {
                        Text("Change Image")
                    }
                    .foregroundColor(.black)
                    .frame(width:200, height:40)
                    .background(Color.white)
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading) {
                        Text("Name")
                        TextField("Post Name",text: $editPost.name)
                        //should populate with original post data
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                            .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                        TextField("Description",text: $editPost.description)
                        //should populate with original post data
                                                .padding()
                                                .frame(width:300, height:50)
                                                .background(Color.white.opacity(0.75))
                                                .cornerRadius(10)
                                                .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Contact Email")
                        TextField("Contact Email",text: $editPost.contactEmail)
                        //should populate with original post data
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                            .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Category")
                            .multilineTextAlignment(.leading)
                        TextField("Category",text: $editPost.category)
                        //should populate with original post data
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                            .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)

                    }

                    
                    Button {
                        dataManager.editPost(id: editPost.id, authId: editPost.authID, name: editPost.name, description: editPost.description, category: editPost.category)
                        dataManager.fetchPosts()
                        dataManager.fetchUserClaims()
                        dataManager.fetchUserPosts()
                    } label: {
                        Text("Save Post")
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                    
                    Button {
                        dataManager.deletePost(id: editPost.id, authId: editPost.authID)
                        dataManager.fetchPosts()
                        dataManager.fetchUserClaims()
                        dataManager.fetchUserPosts()
                    } label: {
                        Text("Delete Post")
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                    
                }
                .padding()
            }
            .navigationTitle("Edit Post")
        }
    }
    
    
//    struct EditPostView_Previews: PreviewProvider {
//        static var previews: some View {
//            EditPostView()
//        }
//    }
}

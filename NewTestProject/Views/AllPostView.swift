//
//  TestAllPostsView.swift
//  NewTestProject
//
//  Created by nina-tuyen tran on 1/30/23.
//

import SwiftUI
import Firebase

struct TestAllPostView: View {
    @EnvironmentObject var dataManager:DataManager
    @StateObject var loginManager = LoginManager()
    @State private var showAdd = false
    @State private var search = ""
    @State private var categories = ["All","Electronics", "Home & Garden", "Clothing", "Baby & Kids","Vehicle","Toys & Games & Hobbies","Sports & Outdoors", "Misc"]
    @State private var category = "All"

    @State private var icon = ""
    
    var body: some View {

        NavigationView {
            VStack{
                    TextField("Search",text:$search)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color("Complimentary"))
                    .cornerRadius(10)
                   
                
                VStack(alignment: .leading) {
                    Text("Filter By Category")
                        .multilineTextAlignment(.leading)
                    Picker("Please choose a category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color("Complimentary"))
                    .cornerRadius(10)
                }

                
                if category != "All" {
                    
                    List(dataManager.posts.filter {$0.category == category}, id:\.id) { post in
                        NavigationLink {
                            TestSinglePostView(post: post)
                        } label: {
                            HStack {
                                Image(icon)
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

                } else if search != "" {
                    List(dataManager.posts.filter {$0.name.localizedCaseInsensitiveContains(search) || $0.description.localizedCaseInsensitiveContains(search)}, id:\.id) { post in
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
                } else {
                    List(dataManager.posts, id:\.id) { post in
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
                    
                }
            }
            .navigationTitle("All Posts")
        }
    }


    struct TestAllPostView_Previews: PreviewProvider {
        static var previews: some View {
            TestAllPostView()
                .environmentObject(DataManager())
        }
    }
}

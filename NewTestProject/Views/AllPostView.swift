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
    @State var filter = "None"
    @State private var filterBy = ["None","Claim Status","Category"]
    @State private var claimStatus = ""
    @State private var isClaimed = ["All","Unclaimed","Claimed"]
    @State private var categories = ["All","Electronics", "Home & Garden", "Clothing", "Baby & Kids","Vehicle","Toys & Games & Hobbies","Sports & Outdoors", "Misc"]
    @State private var category = "All"
    
    
    var body: some View {
        
        NavigationView {

            VStack{
                TextField("Search",text:$search)
                    .padding()
                    .frame(width:300, height:50)
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .onTapGesture{filter = "None"
                        claimStatus = ""
                        category = "All"
                        search = ""
                    }.background(Color("Neutral"))
                
                VStack {
                    
                    HStack{
                        Text("Filter By")
                        Picker("Filter By", selection: $filter) {
                            ForEach(filterBy, id: \.self) { filter in
                                Text(filter.capitalized)
                            }
                        }
                        .onTapGesture{filter = "None"
                            claimStatus = ""
                            category = "All"
                            search = ""
                        }
                    }
                    .background(Color("Neutral"))
                    
                    if filter == "Claim Status" {
                        HStack{
                            Text("Choose Claim Status")
                            Picker("Claimed Status", selection: $claimStatus) {
                                ForEach(isClaimed, id: \.self) { status in
                                    Text(status.capitalized)
                                }
                            }
                            .onTapGesture {
                                category = "All"
                            }
                            
                        }
                    } else if filter == "Category" {
                        HStack{
                            Text("Choose Category")
                            Picker("Category", selection: $category) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category.capitalized)
                                }
                            }
                            .onTapGesture {
                                claimStatus = ""
                            }

                            
                            
                        }
                    }
                    
                   if search != "" {
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
                        .listRowBackground(Color("Neutral"))
                        .scrollContentBackground(.hidden)
                    } else if filter == "None" || (category == "All" && claimStatus == "") {
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
                        .listRowBackground(Color("Neutral"))
                        .scrollContentBackground(.hidden)
                        
                    }else if claimStatus != "" {
                        if claimStatus == "Claimed" {
                        
                        List(dataManager.posts.filter {$0.claimId != ""}, id:\.id) { post in
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
                        .listRowBackground(Color("Neutral"))
                        .scrollContentBackground(.hidden)
                        
                    } else if claimStatus == "Unclaimed" {
                        
                        List(dataManager.posts.filter {$0.claimId == ""}, id:\.id) { post in
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
                        .listRowBackground(Color("Neutral"))
                        .scrollContentBackground(.hidden)
                    }
                        
                    }
                    else if category != "All" {
                        
                        List(dataManager.posts.filter {$0.category == category}, id:\.id) { post in
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
                        }                .listRowBackground(Color("Neutral"))
                            .scrollContentBackground(.hidden)
                        
                    }  else {
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
                }.navigationTitle("All Posts")
            }
        }
    }
}
//struct TestAllPostView_Previews: PreviewProvider {
  //        static var previews: some View {
  //            TestAllPostView()
  //                .environmentObject(DataManager())
  //        }
  //    }

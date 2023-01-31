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

    var body: some View {

        NavigationView {
            VStack{

                TextField("Search",text:$search)
                    .padding()
                    .frame(width:300, height:50)
                    .cornerRadius(10)
                    .background(Color.white.opacity(0.75))
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)

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
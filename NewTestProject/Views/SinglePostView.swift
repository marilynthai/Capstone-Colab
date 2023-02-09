//
//  TestSinglePost.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/31/23.
//
// from all posts to single post
import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

struct TestSinglePostView: View {
    
    var post: Post
    @EnvironmentObject var dataManager:DataManager
    @State private var img:UIImage?
    
    
    

    var body: some View {
        ZStack{
            Color("Neutral")
                .ignoresSafeArea()
            
            VStack {
                List {
                    Text(post.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    
                    if img != nil {
                        Image(uiImage: img!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                    }
                    VStack(alignment: .leading){
                        
                        Text("Description")
                            .fontWeight(.semibold)
                        
                        Text(post.description)
                            .font(.body)
                    }    
                    HStack {
                        Text("Contact")
                            .fontWeight(.semibold)
                        
                        Text(post.contactEmail) //not showing up...
                            .font(.subheadline)
                        
                    }
                    
                    if post.claimId != "" && post.claimId != Auth.auth().currentUser!.uid && post.authID != Auth.auth().currentUser!.uid {
                        Text("Claimed")
                    } else if post.claimId != "" && post.claimId == Auth.auth().currentUser!.uid {
                        Button("Unclaim") {
                            dataManager.unClaimPost(id: post.id,authId: post.authID)
                            dataManager.fetchPosts()
                            dataManager.fetchUserClaims()
                            
                        }
                        .foregroundColor(.black)
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    else if post.claimId == "" && post.authID != Auth.auth().currentUser!.uid {
                        Button("Claim") {
                            dataManager.claimPost(id: post.id,authId: post.authID)
                            dataManager.fetchPosts()
                            dataManager.fetchUserClaims()
                        }
                        .foregroundColor(.black)
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                    } else if post.authID == Auth.auth().currentUser!.uid {
                        if post.claimId != "" {
                            Text("Claimed by: \(post.claimName)")}
                        else {Text("Not Claimed")}
                        NavigationLink(destination: EditPostView(editPost: post)) {
                            Text("Edit Post")
                        }
                    }
                }
                .listRowBackground(Color("Neutral"))
                .scrollContentBackground(.hidden)
            }
            .onAppear(
                perform: {getImage()}
            )
        }
        
    }
//    struct SinglePostView_Previews: PreviewProvider {
//        static var previews: some View {
//            SinglePostView(post: Post)
//        }
//    }
    
    func getImage() {
            let ref = Storage.storage().reference()
            let fileRef = ref.child(post.photoURL)
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if error != nil {
                    print("Error: Image could not download!")
                    print(error!.localizedDescription)
                } else {
                    img = UIImage(data: data!)
                }
            }
        }

}


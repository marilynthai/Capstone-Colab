//
//  TestSinglePost.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/31/23.
//

import Foundation
import SwiftUI

struct TestSinglePostView: View {
    var post: Post
    

    var body: some View {
        VStack {
            List {
                Text(post.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
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
                
            }
        }
    }
    
//    struct SinglePostView_Previews: PreviewProvider {
//        static var previews: some View {
//            SinglePostView(post: Post)
//        }
//    }
    
    
}

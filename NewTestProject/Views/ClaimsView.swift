//
//  ClaimsView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// Marilyn

import SwiftUI

struct ClaimsView: View {
    @EnvironmentObject var dataManager:DataManager
    
    
    var body: some View {
        ZStack{
            NavigationView {
                List(dataManager.userClaims, id:\.id) { post in
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
                }.navigationTitle("My Claims")
                
            }
            
        }
    }
    
    
    struct ClaimsView_Previews: PreviewProvider {
        static var previews: some View {
            ClaimsView()
        }
    }
}

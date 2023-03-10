//
//  ClaimsView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// Marilyn

import SwiftUI
import SDWebImageSwiftUI


struct ClaimsView: View {
    @EnvironmentObject var dataManager:DataManager
    
    
    var body: some View {
        
        ZStack{
            Color("Neutral")
                .ignoresSafeArea()
            
            VStack (alignment: .center){
                Text("My Claims")
                    .font(.system(size: 48, weight: .heavy, width: .expanded))
                    .padding()

                    List(dataManager.userClaims, id:\.id) { post in
                        NavigationLink {
                            TestSinglePostView(post: post)
                        } label: {
                            HStack {
                                if post.photoURL != "" {
                                    WebImage(url: URL(string: post.photoURL))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)
                                        .cornerRadius(4)
                                } else{
                                    Image(systemName:"photo.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 70)
                                        .cornerRadius(4)
                                }
                                
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
    }
    
    
    
    struct ClaimsView_Previews: PreviewProvider {
        static var previews: some View {
            ClaimsView()
        }
    }
}

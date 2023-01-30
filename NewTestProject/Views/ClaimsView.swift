//
//  ClaimsView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// Marilyn

import SwiftUI

struct ClaimsView: View {
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                NavigationLink {
                    SinglePostView()
                } label:{
                    HStack {
                        Image(systemName:"photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 70)
                            .cornerRadius(4)
                        
                        VStack(alignment: .leading){
                            Text("Post Title")
                                .fontWeight(.bold)
                            
                            Text("Claimed")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("My Claims")

        }
    }
}

struct ClaimsView_Previews: PreviewProvider {
    static var previews: some View {
        ClaimsView()
    }
}

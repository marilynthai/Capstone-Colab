//
//  SinglePostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
//

import SwiftUI

struct SinglePostView: View {
    
    var body: some View {
        VStack {
            List {
                Text("Specific Post Title")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                
                Text("Description")
                    .fontWeight(.semibold)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ullamcorper aliquam gravida. Curabitur convallis orci vitae augue volutpat, id venenatis mauris cursus. Ut ac dictum leo. Vestibulum tristique egestas purus, id ultricies dui ultricies eget. Mauris lobortis bibendum lorem malesuada ultrices. Donec viverra dui a diam pretium, sit amet dapibus.")
                    .font(.body)
                
                Text("Type of Pickup")
                    .fontWeight(.semibold)
                
                Text("In-person")
                    .font(.body)
                
                Text("Time of Pickup")
                    .fontWeight(.semibold)
                
                Text("☀️ Morning")
                    .font(.body)
                
                Text("Contact Information")
                    .fontWeight(.semibold)
                
                Text("ninatuyentran@gmail.com")
                    .font(.body)

                
            }
        }
    }
    
    struct SinglePostView_Previews: PreviewProvider {
        static var previews: some View {
            SinglePostView()
        }
    }
}

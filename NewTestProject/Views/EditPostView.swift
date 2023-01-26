//
//  EditPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
//

import SwiftUI

struct EditPostView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var updatedPostName = ""
    @State private var updatedDescription = ""
    
    var body: some View {
        
        VStack {
            Text("Edit Post")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                Button("Change Image"){}
                
                Text("Title")
                    .fontWeight(.semibold)
                TextField("Post Name",text: $updatedPostName)
                
                Text("Description")
                    .fontWeight(.semibold)
                TextField("Description",text: $updatedDescription)
                
                Text("Type of Pickup")
                    .fontWeight(.semibold)
                TextField("Type of Pickup",text: $updatedDescription)
                
                Text("Category")
                    .fontWeight(.semibold)
                TextField("Category",text: $updatedDescription)
            }
            Button {
                dataManager.editPost(name: updatedPostName, description: updatedDescription)
            } label: {
                Text("Save")
            }
        }
    }
    
    
    struct EditPostView_Previews: PreviewProvider {
        static var previews: some View {
            EditPostView()
        }
    }
}

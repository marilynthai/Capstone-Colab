//
//  NewPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
//

import SwiftUI

struct NewPostView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var newPostName = ""
    @State private var newPostDescription = ""
    var body: some View {
        VStack {
            TextField("Post Name",text: $newPostName)
            TextField("Description",text: $newPostDescription)
            
            Button {
                dataManager.addPost(name: newPostName,description: newPostDescription)
            } label: {
                Text("Save")
            }
        }
        .padding()
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}

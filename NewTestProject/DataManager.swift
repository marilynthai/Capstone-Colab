//
//  DataManager.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
//

import SwiftUI
import Firebase

class DataManager:ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        posts.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Posts")
        ref.getDocuments { info, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let info = info {
                for document in info.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let post = Post(id: id, description: description, name: name)
                    self.posts.append(post)
                }
            }
        }
    }
    func addPost(name: String,description:String) {
        let db = Firestore.firestore()
        let ref = db.collection("Posts").document(name)
        ref.setData(["name": name, "description" :description, "id":12]){error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    func editPost(name: String,description:String) {
        let db = Firestore.firestore()
        let ref = db.collection("Posts").document(name)
        ref.setData(["name": name, "description" :description, "id":12]){error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        
    }
}

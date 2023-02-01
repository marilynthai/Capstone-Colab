//
//  DataManager.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
//

import SwiftUI
import Firebase

class DataManager:ObservableObject {
    //all views with @Published variables will be changed when they change
    @Published var db = Firestore.firestore()
    @Published var posts: [Post] = []
    @Published var userPosts: [Post] = []
    @Published var users: [User] = []
    @Published var userClaims: [Post] = []

    
    
    init() {
        fetchPosts()
        fetchUserPosts()
        fetchUsers()
        
    }
    
    func fetchUsers() {
        users.removeAll()
        let ref = db.collection("Users")
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
                    let email  = data["email"] as? String ?? ""
                    let user = User(id: id, email: email, name: name)
                    self.users.append(user)
                }
            }
        }
    }
    
    func addUser(name: String,email:String) {
        let ref = db.collection("Users").document()
        let docId = ref.documentID
        ref.setData(["id":docId,"name": name, "email" :email]){error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    func fetchPosts() {
        posts.removeAll()
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
                    let contactEmail = data["Contact Email"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let authID = data["authID"] as? String ?? ""
                    let claimId = data["claimId"] as? String ?? ""
                    let post = Post(id: id, description: description, name: name, contactEmail: contactEmail, category: category, authID: authID, claimId: claimId)
                    self.posts.append(post)
                }
            }
        }
    }
    
    func fetchUserPosts(){
        userPosts.removeAll()
        let ref = db.collection("Posts")
        ref.getDocuments { info, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let info = info {
                for document in info.documents {
                    let data = document.data()
                    let authID = data["authID"] as? String ?? ""
                    if authID == Auth.auth().currentUser!.uid {
                        let id = data["id"] as? String ?? ""
                        let name = data["name"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let contactEmail = data["Contact Email"] as? String ?? ""
                        let category = data["category"] as? String ?? ""
                        let authID = data["authID"] as? String ?? ""
                        let claimId = data["claimId"] as? String ?? ""
                        let post = Post(id: id, description: description, name: name, contactEmail: contactEmail, category: category, authID: authID, claimId: claimId)
                        self.userPosts.append(post)
                    }
                }
            }
        }
    }
    
    func fetchUserClaims(){
        userClaims.removeAll()
        let ref = db.collection("Posts")
        ref.getDocuments { info, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let info = info {
                for document in info.documents {
                    let data = document.data()
                    let claimID = data["claimId"] as? String ?? ""
                    if claimID == Auth.auth().currentUser!.uid {
                        let id = data["id"] as? String ?? ""
                        let name = data["name"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let contactEmail = data["Contact Email"] as? String ?? ""
                        let category = data["category"] as? String ?? ""
                        let authID = data["authID"] as? String ?? ""
                        let claimId = data["claimId"] as? String ?? ""
                        let post = Post(id: id, description: description, name: name, contactEmail: contactEmail, category: category, authID: authID, claimId: claimId)
                        self.userClaims.append(post)
                    }
                }
            }
        }
    }
    
    func addPost(name: String,description:String,contactEmail:String, category:String) {
        let ref = db.collection("Posts").document()
        let docId = ref.documentID
        let authID = Auth.auth().currentUser!.uid
        ref.setData(["id":docId,"name": name, "description" :description,"contact email":contactEmail, "category": category, "authID":authID]){error in
            if error != nil {
                print("could not add post")
            }
        }
        
    }
    
    func claimPost(id:String,authId:String) {
        let ref = db.collection("Posts").document(id)
                let currentAuthId = Auth.auth().currentUser!.uid
                if authId != currentAuthId {
                    ref.updateData([
                        "claimId":currentAuthId
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
        
                } else {
                    print("User cannot claim own post!")
                }
            }
    
    func unClaimPost(id:String,authId:String) {
        let ref = db.collection("Posts").document(id)
                let currentAuthId = Auth.auth().currentUser!.uid
                if authId != currentAuthId {
                    ref.updateData([
                        "claimId":""
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
        
                } else {
                    print("User cannot unclaim own post!")
                }
            }
    
    func editPost(id:String,authId:String,name:String,description:String,category:String) {
        let ref = db.collection("Posts").document(id)
                let currentAuthId = Auth.auth().currentUser!.uid
                if authId == currentAuthId {
                    ref.updateData([
                        "description":description,
                        "name":name,
                        "category": category
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
        
                } else {
                    print("User cannot edit others posts!")
                }
            }
    
    func deletePost(id:String,authId:String) {
        let currentAuthId = Auth.auth().currentUser!.uid
        if authId == currentAuthId {
            db.collection("Posts").document(id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        
    }
    }


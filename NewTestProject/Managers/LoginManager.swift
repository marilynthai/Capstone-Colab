//
//  LoginManager.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/30/23.
//

//import Foundation
//import SwiftUI
//import Firebase
//
//class LoginManager : ObservableObject {
//    @Published var isLoggedIn = false
//    @Published var userID = ""
//    
//    func login(email:String, password:String) {
//
//        Auth.auth().signIn(withEmail: email, password: password) {result , error in
//            if error != nil {
//                print(error!.localizedDescription)
//            } else {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    withAnimation {
//                        self.isLoggedIn = true
//                    }
//                }
//                guard let userID = Auth.auth().currentUser?.uid else { return }
//                print(userID)
//                
//            }
//        }
//    }
//}

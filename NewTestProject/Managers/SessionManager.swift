//
//  SessionManager.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/30/23.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class UserTest {
    var uid: String
    var email: String?
    var displayName: String?

    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }

}

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: UserTest? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = UserTest(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    func signUp(
            email: String,
            password: String,
            handler: @escaping(AuthDataResult?, Error?) -> Void
            ) {
            Auth.auth().createUser(withEmail: email, password: password, completion: handler)
                
        }

        func signIn(
            email: String,
            password: String) {
            Auth.auth().signIn(withEmail: email, password: password)
                print("logged in")
                print(self.session)
        }

        func signOut () -> Bool {
            do {
                try Auth.auth().signOut()
                self.session = nil
                return true
            } catch {
                return false
            }
        }
        func unbind () {
            if let handle = handle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }

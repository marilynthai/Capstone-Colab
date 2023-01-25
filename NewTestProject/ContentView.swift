//
//  ContentView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var email=""
    @State private var password=""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn {
            HomeView()
        } else {
            content
        }
    }
    
    var content: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            TextField("Email", text: $email)
                .padding(.all)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            TextField("Password", text: $password)
                .padding(.all)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
            Button("Sign Up") {
                register()
            }
            .padding(.all)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
            
            
            Button("Login") {
                login()
            }
            .padding()
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .onAppear(){
                Auth.auth().addStateDidChangeListener{auth,user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
            }
            
        }
        .padding()
    }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {result , error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result , error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}

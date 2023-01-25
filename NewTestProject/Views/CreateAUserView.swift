//
//  ContentView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
// Marilyn

import SwiftUI
import Firebase

struct CreateAUserView: View {
    @State private var email=""
    @State private var password=""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.blue
                    .opacity(0.25)
                    .ignoresSafeArea()
                VStack{
                    Text("Create A New User")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                    
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                    
                    Button("Sign Up") {
                        register()
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    
                    Button("Login") {
                        login()
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .onAppear(){
                        Auth.auth().addStateDidChangeListener{auth,user in
                            if user != nil {
                                userIsLoggedIn.toggle()
                            }
                        }
                    }
                }
                 .padding()
             }
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
    
    struct CreateAUserView_Previews: PreviewProvider {
        static var previews: some View {
            CreateAUserView()
            
        }
    }
    
}

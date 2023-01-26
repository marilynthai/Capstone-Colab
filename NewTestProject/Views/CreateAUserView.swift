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
    @State private var createdUser = false

    
    var body: some View {
        NavigationView{
            ZStack {
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
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                        .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.automatic/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    
                    Button("Sign Up") {
                        register()
                        createdUser = true
                        email = ""
                        password = ""
                        
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    NavigationLink(destination:Text("You have successfully created an account!"), isActive: $createdUser) {
                        EmptyView()
                    }
                    
//
//                    Button("Login") {
//                        login()
//                    }
//                    .foregroundColor(.black)
//                    .frame(width:300, height:50)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .onAppear(){
//                        Auth.auth().addStateDidChangeListener{auth,user in
//                            if user != nil {
//                                userIsLoggedIn.toggle()
//                            }
                        }
                    }

                }
                 .padding()
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

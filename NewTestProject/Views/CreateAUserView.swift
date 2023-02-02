//
//  ContentView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
// Marilyn

import SwiftUI
import Firebase

struct CreateAUserView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var email=""
    @State private var password=""
    @State private var firstName=""
    @State private var lastName=""
    @State private var userIsLoggedIn = false
    @State private var createUser = false


    
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
                        
                        TextField("First Name", text: $firstName)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        
                        
                        TextField("Last Name", text: $lastName)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        
                        
                        TextField("Email", text: $email)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        
                        
                        TextField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        
                        
                        
                        Button("Sign Up") {
                            register()
                            dataManager.addUser(name: firstName ,email: email)
                            createUser = true
                            email = ""
                            password = ""
                            firstName=""
                            lastName=""
                            
                        }
                        .foregroundColor(.black)
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                
                        }
                .alert("User Created. Please login with email and password.", isPresented: $createUser, actions: {})

                    }

                }
                 .navigationBarHidden(true)
        
             }
    
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) {result , error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    struct CreateAUserView_Previews: PreviewProvider {
        static var previews: some View {
            CreateAUserView()
                .environmentObject(DataManager())
            
        }
    }
    
}

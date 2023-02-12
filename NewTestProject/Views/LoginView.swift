//
//  LoginView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// 

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager


    @State private var email = ""
    @State private var password = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var wrongUsername = 0
    @State private var showingLoginScreen = false
    @State private var id = ""
    @State private var invalidUserData = false

    let radius: CGFloat = 100
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Neutral")
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color("LightBlue"))
                
                VStack(alignment: .trailing){
                    Image("handshake")
                        .resizable()
                        .frame(
                            width: radius * 2,
                            height: radius * 2)
                }


                VStack {
                    Text("GOTCHU")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
                        .font(.system(size: 48, weight: .heavy, width: .expanded))
                        .foregroundColor(.blue)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                    
                        .border(.red,width: CGFloat(wrongEmail))
                        .border(.red,width: CGFloat(wrongUsername))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    //label to limit front end

                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                        .border(.red,width: CGFloat(wrongPassword))
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
               
                    Button("Login") {
                        loginManager.login(email: email, password: password)
                        login()
                        dataManager.fetchUser()

                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color("Accent"))
                    .cornerRadius(10)
                    .disabled(email.isEmpty || password.isEmpty)
                    .buttonStyle(.plain)
                    
                    
    
                }.alert("Invalid email or password.", isPresented: $invalidUserData, actions: {})
                
                

            }.navigationBarHidden(true)
        }
    }

    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {result , error in
            if error != nil {
                print(error!.localizedDescription)
                invalidUserData = true
            } else {
                wrongPassword = 0
                showingLoginScreen = true
                invalidUserData = false
//                grabUserInformation()
                
                
            }
        }
    }
    
//    attempting to grab user id and set to a global variable
//    func grabUserInformation() {
//        dataManager.fetchUsers()
//        let users = dataManager.users
//        for user in users {
//            if user.email != email {
//                print("No user found with that email, cannot assign id state")
//            } else {
//                id = user.id
//                print(id)
//            }
//        }
//    }
        
        struct LoginView_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
            
        }
    }




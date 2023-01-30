//
//  TestContentView.swift
//  NewTestProject
//
//  Created by nina-tuyen tran on 1/30/23.
//

import SwiftUI
import Firebase

class LoginManager : ObservableObject {
    @Published var isLoggedIn = false
    @Published var userID = ""
    
    func login(email:String, password:String) {

        Auth.auth().signIn(withEmail: email, password: password) {result , error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        self.isLoggedIn = true
                    }
                }
                guard let userID = Auth.auth().currentUser?.uid else { return }
                print(userID)
                
            }
        }
    }
}

//Home View
    struct TestContentView : View {
        @StateObject var loginManager = LoginManager()
        @EnvironmentObject var dataManager:DataManager
        
        var body: some View {
            if loginManager.isLoggedIn {
                TestAllPostsView().environmentObject(DataManager())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .leading))
            } else {
                TestLoginView(loginManager: loginManager)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .leading))
            }
        }
    }
//Login
    struct TestLoginView : View {
        @ObservedObject var loginManager : LoginManager
        @EnvironmentObject var dataManager:DataManager
        @State private var email = ""
        @State private var password = ""
        @State private var wrongEmail = 0
        @State private var wrongPassword = 0
        @State private var wrongUsername = 0
        @State private var showingLoginScreen = false
        @State private var id = ""
        
        
        var body: some View {
            NavigationView {
                ZStack {
                    Color.blue
                        .opacity(0.25)
                        .ignoresSafeArea()
                    VStack {
                        Text("TBD App Name")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
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
//                            login()
                            loginManager.login(email: email, password: password)
                        }
                        .foregroundColor(.black)
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        NavigationLink(destination: CreateAUserView()) {
                            Text("Don't have an account? Sign up here")
                        }
                    }
                }
                .navigationBarHidden(true)
            }
        }
        
        
        func login() {
            Auth.auth().signIn(withEmail: email, password: password) {result , error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    wrongPassword = 0
                    showingLoginScreen = true
                    //                grabUserInformation()
                    
                    
                }
            }
        }
        
        //        Button("Login") {
        //            loginManager.login()
        //        }
    }
    
    
    
    struct TestAllPostsView : View {
        @EnvironmentObject var dataManager:DataManager
        @State private var showAdd = false
        @State private var search = ""
        
        var body: some View {
            NavigationView {
                
                VStack{
                    TextField("Search",text:$search)
                        .padding()
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(0.75))
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    
                    List(dataManager.posts, id:\.id) { post in
                        NavigationLink {
                            SinglePostView()
                        } label: {
                            HStack {
                                Image(systemName:"photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                    .cornerRadius(4)
                                
                                VStack(alignment: .leading){
                                    Text(post.name)
                                        .fontWeight(.bold)
                                    
                                    Text(post.description)
                                        .font(.subheadline)
                                }
                            }
                        }
                        
                        
                    }
                    Button {
                    let firebaseAuth = Auth.auth()
                       do {
                         try firebaseAuth.signOut()
                           print("signed out")
                           guard let userID = Auth.auth().currentUser?.uid else { return print("No user")}
                           print(userID)
                       } catch let signOutError as NSError {
                         print("Error signing out: %@", signOutError)
                       }
                    } label: {
                        Text("Log Out")
                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                    
                    .navigationTitle("Posts")
                    //                 adding a post with + button
                    .navigationBarItems(trailing:Button(action:{
                        showAdd.toggle()
                    },label: {
                        Image(systemName:"plus")
                    }))
                    .sheet(isPresented: $showAdd){
                        CreatePostView()
                    }
                }
            }
        }
    }


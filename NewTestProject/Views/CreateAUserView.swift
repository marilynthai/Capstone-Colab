//
//  ContentView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
// Marilyn

import SwiftUI
import Firebase
import FirebaseStorage

struct CreateAUserView: View {
    @EnvironmentObject var dataManager:DataManager
    @State private var email=""
    @State private var password=""
    @State private var firstName=""
    @State private var lastName=""
    @State private var userIsLoggedIn = false
    @State private var createUser = false

    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var isPickerShowing = false
    @State var selectedImage = UIImage()

    let radius: CGFloat = 100

    
    var body: some View {
        NavigationView{
            ZStack {
                Color("Neutral")
                    .ignoresSafeArea()
                VStack{
                    
                    Text("Create A New User")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    
                    ZStack(alignment: .bottomTrailing){

                        Button(action: {
                            isPickerShowing = true
                            changeProfileImage = true
                            openCameraRoll = true
                        }, label: {
                            if changeProfileImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: radius * 2,
                                        height: radius * 2)
                                    .clipShape(Circle())
                                
                            } else {
                                Image(systemName:"person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: radius * 2,
                                        height: radius * 2)
                                
                            }})
                        
                        Image(systemName:"camera.fill")
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(Color.gray)
                            .clipShape(Circle())
                            .background(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2))
                        
                    }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                        ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                    }
                    
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
                        .foregroundColor(Color.black)
                        .frame(width:300, height:50)
                        .background(Color("Accent"))
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
    
    
    func uploadPhoto() -> String {
        // Make sure that the selected image property isn't nil
        guard selectedImage != nil else {
            return "No image selected"
        }
        
        // Create a storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        
        // CHeck that the file is able to to convert to data
        guard imageData != nil else {
            return "yes"
        }
        
        // Specify the file path and name
        let imagePath = "userImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(imagePath)
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for errors
            
            if error == nil && metadata != nil {
                // to do: save a reference t the file in the DB
                
            }
            
        }
        return imagePath
    }
    
    
    struct CreateAUserView_Previews: PreviewProvider {
        static var previews: some View {
            CreateAUserView()
                .environmentObject(DataManager())
            
        }
    }
    
}

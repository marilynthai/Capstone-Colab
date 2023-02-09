//
//  NewPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
// Marilyn

import SwiftUI
import Firebase
import FirebaseStorage


struct CreatePostView: View {
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    @State private var newPostName = ""
    @State private var newPostDescription = ""
    @State private var category = "Pick A Category"
    @State private var claimId = ""
    @State private var claimName = ""
    @State private var createdPost = false
    @State private var categories = ["Pick A Category","Electronics", "Home & Garden", "Clothing", "Baby & Kids","Vehicle","Toys & Games & Hobbies","Sports & Outdoors", "Misc"]
    @State private var photoURL = ""
    
    
    // create state variables for camera
    
    @State var changePostImage = false
    @State var openCameraRoll = false
    
    @State var isPickerShowing = false
    @State var selectedImage = UIImage()
    
    var body: some View {
        ZStack{
            Color("Neutral")
                .ignoresSafeArea()
            //                VStack {
            ScrollView{
                VStack (alignment: .center) {
                    Text("Create A Post")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .padding()

                    if changePostImage != true {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .frame(width: 200, height:200)
                    } else {
                        if selectedImage != nil {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .frame(width:200, height: 200)
                        }}
                
                    VStack (alignment: .center) {
                    Button {
                        isPickerShowing = true
                        changePostImage = true
                    } label: {
                        Text("Select a Photo")
                    }
                    .frame(width:300, height:50)
                    .background(Color("Accent"))
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                    .padding()
                    
//                    if selectedImage != nil {
//                        Button {
//                            // Upload the image
//                            uploadPhoto()
//                        } label: {
//                            Text("Upload Image")
//                        }
//                        .frame(width:300, height:50)
//                        .background(Color("Complimentary"))
//                        .cornerRadius(10)
//                        .padding()
//                    }
                }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                }
                    VStack(alignment: .center){
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.headline)
                        
                        
                        TextField("Post Name",text: $newPostName)
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                        
                        Text("Description")
                        TextField("Description",text: $newPostDescription, axis:.vertical)
                            .lineLimit(2...6)
                            .padding()
                            .frame(width:300)
                            .background(Color.white)
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing}
                        
                        Text("Contact Email")
                        Text(loginManager.userEmail)
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                        Text("Category")
                            .multilineTextAlignment(.leading)
                        Picker("Please choose a category", selection: $category) {
                            ForEach(categories, id: \.self) {
                                Text($0)
                                    .foregroundColor(.black)
                            }
                        }
                        .tint(.black)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                        Button {
                            
                        dataManager.addPost(name: newPostName,description: newPostDescription,contactEmail: loginManager.userEmail,category: category, claimName: claimName,claimId: claimId,photoURL:uploadPhoto())
                        newPostName = ""
                        newPostDescription = ""
                        category = ""
                        dataManager.fetchPosts()
                        dataManager.fetchUserPosts()
                        createdPost = true
                        
                        
                    } label: {
                        Text("Save Post")
                    }
                    
                    .disabled(newPostName.isEmpty || newPostDescription.isEmpty || category == "Pick A Category")
                    .buttonStyle(.plain)
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color("Accent"))
                    .cornerRadius(10)
                    .padding()
                }
            }
            }
            
        }
    }
    
        //            Button(action: {
        //                changePostImage = true
        //                openCameraRoll = true
        //                // iupload the image
        //                uploadPhoto()
        //
        //            }, label: {
        //                if changePostImage {
        //                    VStack{
        //                        Image(uiImage: selectedImage)
        //                            .resizable()
        //                            .frame(width:220, height: 220)
        //                        Text("Change image")
        //                    }
        //
        //                } else {
        //                    VStack {
        //                        Image(systemName: "folder.badge.plus")
        //                            .resizable()
        //                            .frame(width:220, height: 220)
        //                        Text("Upload an image")
        //                    }
        //                }
        //            })
        
//        .sheet(isPresented: $openCameraRoll) {ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)}
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
        let imagePath = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(imagePath)
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for errors
            
            if error == nil && metadata != nil {
                // to do: save a reference t the file in the DB
                
            }
            
        }
        return imagePath
        // Save a reference to the file in Firestore DB
    }
}
    
    //                    .foregroundColor(.black)
    //                    .frame(width:200, height:40)
    //                    .background(Color.white)
    //                    .cornerRadius(10)
    //
    //                    VStack(alignment: .leading) {
    //                        Text("Name")
    //                        TextField("Post Name",text: $newPostName)
    //                            .padding()
    //                            .frame(width:300, height:50)
    //                            .background(Color.white.opacity(0.75))
    //                            .cornerRadius(10)
    //                            .disableAutocorrection(true)
    //                    }
    //
    //                    VStack(alignment: .leading) {
    //                        Text("Description")
    //                        TextField("Description",text: $newPostDescription, axis:.vertical)
    //                            .lineLimit(2...6)
    //                            .padding()
    //                            .frame(width:300)
    //                            .background(Color.white.opacity(0.75))
    //                            .cornerRadius(10)
    //                            .disableAutocorrection(true)
    //                    }
    //                    .onAppear {
    //                        UITextField.appearance().clearButtonMode = .whileEditing
    //                    }
    //
    //                    VStack(alignment: .leading) {
    //                        Text("Contact Email")
    //                        Text(loginManager.userEmail)
    //                            .padding()
    //                            .frame(width:300, height:50)
    //                            .background(Color.white.opacity(0.75))
    //                            .cornerRadius(10)
    //                    }
    //                    VStack(alignment: .leading) {
    //                        Text("Category")
    //                            .multilineTextAlignment(.leading)
    //                        Picker("Please choose a category", selection: $category) {
    //                            ForEach(categories, id: \.self) {
    //                                Text($0)
    //                                    .foregroundColor(.black)
    //                            }
    //                        }
    //                        .tint(.black)
    //                        .padding()
    //                        .frame(width:300, height:50)
    //                        .background(Color.white.opacity(0.75))
    //                        .cornerRadius(10)
    //                    }
    //
    //                        Button {
    //                            dataManager.addPost(name: newPostName,description: newPostDescription,contactEmail: loginManager.userEmail,category: category, claimName: claimName,claimId: claimId)
    //                            newPostName = ""
    //                            newPostDescription = ""
    //                            category = ""
    //                            dataManager.fetchPosts()
    //                            dataManager.fetchUserPosts()
    //                            createdPost = true
    //
    //
    //                        } label: {
    //                            Text("Save Post")
    //                        }
    //
    //                        .disabled(newPostName.isEmpty || newPostDescription.isEmpty || category.isEmpty)
    //                        .buttonStyle(.plain)
    //                        .foregroundColor(.black)
    //                        .frame(width:300, height:50)
    //                        .background(Color.white)
    //                        .cornerRadius(10)
    //                        .padding()
    //
    //
    //                    }
    //                    .alert("Post Created", isPresented: $createdPost, actions: {})
    //                    .padding()
    //                }
    //                New Post
    //            }
    //        }
struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
            .environmentObject(DataManager())
            .environmentObject(LoginManager())
    }
}

//
//  EditPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI


struct EditPostView: View {
    @State var editPost:Post
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    @State private var categories = ["Electronics", "Home & Garden", "Clothing", "Baby & Kids","Vehicle","Toys & Games & Hobbies","Sports & Outdoors", "Misc"]
    @State private var createdPost = false
    @State private var img:UIImage?
    @State private var photoURL = ""
    @State private var imagePath = ""
    @State private var imageUploaded = true
    @State var openCameraRoll = false
    
    @State var isPickerShowing = false
    @State var selectedImage = UIImage()
    @FocusState var isFocused: Bool

    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Neutral")
                    .ignoresSafeArea()
                ScrollView{
                    VStack {
                        Text("Edit Post")
                            .font(.system(size: 48, weight: .heavy, width: .expanded))
                            .padding()
                        

                            if editPost.photoURL != "" && selectedImage == UIImage() {
                                WebImage(url: URL(string: editPost.photoURL))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 70)
                                    .cornerRadius(4)
                            } else if selectedImage != UIImage() {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .frame(width:200, height: 200)
                                        
                            } else {
                                Image(systemName:"photo.fill")
                                    .resizable()
                                    .frame(width:200, height: 200)
                            }
                        
                        VStack (alignment: .center) {
                            Button {
                                isPickerShowing = true
                            } label: {
                                Text("Select a Photo")
                            }
                            .frame(width:300, height:50)
                            .background(Color("Accent"))
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                            .padding()
                        
                            if selectedImage != nil {
                                Button {
                                    uploadPhoto()
                                } label: {
                                    Text("Upload Image")
                                }
                                .frame(width:300, height:50)
                                .background(Color("Accent"))
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                                .padding()
                            }
                            
                        }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)}
                        
                        
                        VStack(alignment: .leading) {
                            Text("Name")
                            TextField("Post Name",text: $editPost.name)
                            //should populate with original post data
                                .padding()
                                .frame(width:300, height:50)
                                .background(Color.white.opacity(0.75))
                                .cornerRadius(10)
                                .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .focused($isFocused)

                        }
                        
                        VStack(alignment: .leading) {
                            Text("Description")
                            TextField("Description",text: $editPost.description)
                            //should populate with original post data
                                .padding()
                                .frame(width:300, height:50)
                                .background(Color.white.opacity(0.75))
                                .cornerRadius(10)
                                .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .focused($isFocused)

                        }
                        
                        VStack(alignment: .leading) {
                            Text("Contact Email")
                            Text(loginManager.userEmail)
                            //should populate with original post data
                                .padding()
                                .frame(width:300, height:50)
                                .background(Color.white.opacity(0.75))
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Category")
                                .multilineTextAlignment(.leading)
                            Picker("Please choose a category", selection: $editPost.category) {
                                ForEach(categories, id: \.self) {
                                    Text($0)
                                        .foregroundColor(.black)
                                }
                            }
                            .tint(.black)
                            .padding()
                            .frame(width:300, height:50)
                            .background(Color.white.opacity(0.75))
                            .cornerRadius(10)
                            .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        }
                        
                        
                        Button {
                            
                            dataManager.editPost(id: editPost.id, authId: editPost.authID, name: editPost.name, description: editPost.description, category: editPost.category,photoURL:photoURL)
                            dataManager.fetchPosts()
                            dataManager.fetchUserClaims()
                            dataManager.fetchUserPosts()
                            createdPost = true
                            selectedImage = UIImage()
                            openCameraRoll = false
                            isPickerShowing = false
                            
                        } label: {
                            Text("Save Post")
                        }
                        .foregroundColor(.black)
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                        .disabled(imageUploaded == false)
                        
                        Button {
                            dataManager.deletePost(id: editPost.id, authId: editPost.authID)
                            dataManager.fetchPosts()
                            dataManager.fetchUserClaims()
                            dataManager.fetchUserPosts()
                        } label: {
                            Text("Delete Post")
                        }
                        .foregroundColor(.black)
                        .frame(width:300, height:50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                        
                    }
                    .padding()
                    .onTapGesture {
                        isFocused = false
                    }
                }.onTapGesture {
                    isFocused = false
                }
                
            }
        }
    }
        
        
  
    
    func uploadPhoto() -> String {
        // Make sure that the selected image property isn't nil
        guard selectedImage != nil else {
            return "No image selected"
        }
        imageUploaded = false
        // Create a storage reference
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        
        // CHeck that the file is able to to convert to data
        guard imageData != nil else {
            return "yes"
        }
        
        // Specify the file path and name
        imagePath = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(imagePath)
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for errors
            
            if error == nil && metadata != nil {
                print("photo called")
                let imageRef = storageRef.child(imagePath)
                imageRef.downloadURL { (url, error) in
                    guard error == nil else {
                        print("cannot create url download")
                        print(error?.localizedDescription)
                        return
                    }
                    guard let url = url else{
                        print("url is nil")
                        return
                    }
                    photoURL = "\(url)"
                    imageUploaded = true

                }
            }
            
        }
        return "photo URL uploaded"
    }

}

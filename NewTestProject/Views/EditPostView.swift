//
//  EditPostView.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/25/23.
//

import SwiftUI
import FirebaseStorage


struct EditPostView: View {
    @State var editPost:Post
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    @State private var categories = ["Electronics", "Home & Garden", "Clothing", "Baby & Kids","Vehicle","Toys & Games & Hobbies","Sports & Outdoors", "Misc"]
    @State private var createdPost = false
    @State private var img:UIImage?

    @State var changePostImage = false
    @State var openCameraRoll = false
    
    @State var isPickerShowing = false
    @State var selectedImage = UIImage()
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("Neutral")
                    .ignoresSafeArea()
                ScrollView{
                    VStack {
                        Text("Edit Post")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding()
                        
                        if changePostImage != true && img != nil {
                            Image(uiImage: img!)
                                .resizable()
                                .frame(width:200, height: 200)
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
                            
                        }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)}
                        
                        //                    Button {
                        //                    } label: {
                        //                        Text("Change Image")
                        //                    }
                        //                    .foregroundColor(.black)
                        //                    .frame(width:200, height:40)
                        //                    .background(Color.white)
                        //                    .cornerRadius(10)
                        //                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        //                    .buttonBorderShape(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=shape: ButtonBorderShape@*/.roundedRectangle/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            Text("Name")
                            TextField("Post Name",text: $editPost.name)
                            //should populate with original post data
                                .padding()
                                .frame(width:300, height:50)
                                .background(Color.white.opacity(0.75))
                                .cornerRadius(10)
                                .border(Color.black.opacity(0.25), width: /*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
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
                            dataManager.editPost(id: editPost.id, authId: editPost.authID, name: editPost.name, description: editPost.description, category: editPost.category,photoURL:uploadPhoto())
                            dataManager.fetchPosts()
                            dataManager.fetchUserClaims()
                            dataManager.fetchUserPosts()
                            createdPost = true
                            selectedImage = UIImage()
                            changePostImage = false
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
                        
                    }.onAppear(
                        perform: {getImage()}
                    )
                    .padding()
                }
                
            }
        }
    }
        
        
    func getImage() {
            let ref = Storage.storage().reference()
            let fileRef = ref.child(editPost.photoURL)
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if error != nil {
                    print("Error: Image could not download!")
                    print(error!.localizedDescription)
                } else {
                    img = UIImage(data: data!)
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

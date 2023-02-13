//
//  MyUserView.swift
//  NewTestProject
//
//  Created by nina-tuyen tran on 2/8/23.
//

import SwiftUI
import Firebase
import FirebaseStorage


struct MyUserView: View {
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    @State private var img:UIImage?
    let radius: CGFloat = 100


    
    
    var body: some View {
        ZStack{
            Color("Neutral")
                .ignoresSafeArea()
            VStack(alignment: .center){
                
                if img != nil {
                    Image(uiImage: img!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: radius * 2,
                            height: radius * 2)
                        .clipShape(Circle())
                }else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width:100, height: 100)
                }
                
                Text("My Profile")
                    .font(.system(size: 35, weight: .heavy, width: .expanded))
                    .padding()
                
                
                Image(systemName: "arrow.up.heart")
                    .resizable()
                    .frame(width:75, height: 75)
                Text("Given: \(dataManager.userPosts.count) ")
                    .font(.title)
                    .padding()
                
                Image(systemName: "arrow.down.heart")
                    .resizable()
                    .frame(width:75, height: 75)
                Text("Received: \(dataManager.userClaims.count) ")
                    .font(.title)
                    .padding()
                
                
                Button {
                    loginManager.logout()
                } label: {
                    Text("Log Out")
                }
                .font(.system(.headline, design: .rounded))
                .padding()
                .foregroundColor(.black)
                .background(Color("Accent"))
                .cornerRadius(10)

            }
            .onAppear(
                perform: {getImage(url:dataManager.user.url)})
            
        }
    }
    func getImage(url:String) {
            let ref = Storage.storage().reference()
            let fileRef = ref.child(url)
            fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                if error != nil {
                    print("Error: Image could not download!")
                    print(error!.localizedDescription)
                } else {
                    img = UIImage(data: data!)
                }
            }
        }
    
}

struct MyUserView_Previews: PreviewProvider {
    static var previews: some View {
        MyUserView()
            .environmentObject(LoginManager())
    }
}

//
//  MyUserView.swift
//  NewTestProject
//
//  Created by nina-tuyen tran on 2/8/23.
//

import SwiftUI
import Firebase


struct MyUserView: View {
    @EnvironmentObject var dataManager:DataManager
    @EnvironmentObject var loginManager:LoginManager
    
    
    var body: some View {
        ZStack{
            Color("Neutral")
                .ignoresSafeArea()
            VStack(alignment: .center){
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width:100, height: 100)
                
                Text("My Profile")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding()
                
                
                Image(systemName: "arrow.up.heart")
                    .resizable()
                    .frame(width:75, height: 75)
                Text("Given:\(dataManager.userPosts.count) ")
                    .font(.title)
                    .padding()
                
                Image(systemName: "arrow.down.heart")
                    .resizable()
                    .frame(width:75, height: 75)
                Text("Received:\(dataManager.userClaims.count) ")
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
            
        }
    }
}

struct MyUserView_Previews: PreviewProvider {
    static var previews: some View {
        MyUserView()
            .environmentObject(LoginManager())
    }
}

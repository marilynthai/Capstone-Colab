//
//  NewTestProjectApp.swift
//  NewTestProject
//
//  Created by Marilyn Thai on 1/24/23.
//

import SwiftUI
import Firebase


@main
struct NewTestProjectApp: App {
    @EnvironmentObject var loginManager:LoginManager
    @EnvironmentObject var dataManager:DataManager

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(DataManager())
                .environmentObject(LoginManager())

        }
    }
}

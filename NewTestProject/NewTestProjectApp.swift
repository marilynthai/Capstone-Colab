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
    @StateObject var dataManager = DataManager()

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(DataManager())

            
        }
    }
}

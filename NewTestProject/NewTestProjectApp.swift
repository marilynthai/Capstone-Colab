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
    //Marilyn's Comment
    // comment from nina
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

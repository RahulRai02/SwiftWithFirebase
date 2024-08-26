//
//  SwiftWithFirebaseAppApp.swift
//  SwiftWithFirebaseApp
//
//  Created by Rahul Rai on 13/07/24.
//

import SwiftUI
import Firebase

@main
struct SwiftWithFirebaseAppApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Configured Firebase")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

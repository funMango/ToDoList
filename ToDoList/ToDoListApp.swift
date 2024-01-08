//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by 이민호 on 1/8/24.
//

import SwiftUI
import Firebase

@main
struct ToDoListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
                
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configured Firebase!")

    return true
  }
}

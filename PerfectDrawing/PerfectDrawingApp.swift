//
//  PerfectDrawingApp.swift
//  PerfectDrawing
//
//  Created by Ethan Chew on 5/6/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
  }
}

@main
struct PerfectDrawingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .preferredColorScheme(.light)
        }
    }
}

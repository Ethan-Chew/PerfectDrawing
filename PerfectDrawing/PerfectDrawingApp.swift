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
    let appData = AppData()
    let storageManager = StorageManager()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .onAppear() {
                    func reloadImg() {
                        appData.isFirstOpen.toggle()
                        storageManager.reloadImages()
                        appData.lastDataUpdate = Int(Date().timeIntervalSince1970)
                    }
                    
                    if (appData.isFirstOpen) {
                        reloadImg()
                    }
                    
                    let currTime = Int(Date().timeIntervalSince1970)
                    
                    if (appData.lastDataUpdate + 172800 < currTime) {
                        reloadImg()
                    }
                }
        }
    }
}

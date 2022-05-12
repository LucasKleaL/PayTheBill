//
//  PayTheBillApp.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 03/05/22.
//

import SwiftUI
import Firebase

@main
struct PayTheBillApp: App {
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

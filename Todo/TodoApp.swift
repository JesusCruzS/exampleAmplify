//
//  TodoApp.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 18/04/24.
//

import SwiftUI

@main
struct TodoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Resolver.shared.injectModules()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

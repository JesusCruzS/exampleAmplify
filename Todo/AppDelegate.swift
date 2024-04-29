//
//  AppDelegate.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation
import SwiftUI
import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        do {
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
        return true
    }
}

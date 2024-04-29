//
//  SignUpViewModel.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 19/04/24.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin

class SignInViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""

    
    func signIn() async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
                )
            print(signInResult)
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }

        print("Local signout successful: \(signOutResult.signedOutLocally)")
    }
}

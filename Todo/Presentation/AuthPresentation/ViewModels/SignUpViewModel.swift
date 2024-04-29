//
//  SignUpViewModel.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 19/04/24.
//

import Foundation
import Amplify

class SignUpViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var confirmationCode: String = ""
    
    func signUp() async {
        print("username self = \(self.username) \n username \(username)")
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
            } else {
                print("SignUp Complete")
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

    func confirmSignUp() async {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: "legin098",
                confirmationCode: "804833"
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}

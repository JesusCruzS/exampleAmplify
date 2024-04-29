//
//  SignUpView.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 19/04/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
       
    var body: some View {
        VStack {
            Spacer()
            VStack {
                TextField(
                    "Email",
                    text: $viewModel.email
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                TextField(
                    "Username",
                    text: $viewModel.username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                   
                Divider()
                   
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .padding(.top, 20)
                   
                Divider()
            }
               
            Spacer()
               
            Button(
                action: {
                    Task {
                        await viewModel.signUp()
                    }
                },
                label: {
                    Text("SignUp")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                   }
               )
            Button(
                action: {
                    Task {
                        await viewModel.confirmSignUp()
                    }
                },
                label: {
                    Text("Confirm")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                   }
               )
           }
           .padding(30)
        
    }
}

#Preview {
    SignUpView()
}

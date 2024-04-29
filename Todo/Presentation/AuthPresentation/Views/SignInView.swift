//
//  SignInView.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 22/04/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel = SignInViewModel()
       
    var body: some View {
        VStack {
            Spacer()
            VStack {
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
                        await viewModel.signIn()
                    }
                },
                label: {
                    Text("Sign In")
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
                        await viewModel.signOutLocally()
                    }
                },
                label: {
                    Text("Sign Out")
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
    SignInView()
}

//
//  SignInEmailView.swift
//  SwiftWithFirebaseApp
//
//  Created by Rahul Rai on 14/07/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    

    
    // 2nd  way:  Using Task
    func signUp() async throws{
        // Unwrapping the email id and password
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email,
                                                        password: password)
        
        
//        Task{
//            do{
//                let userReturnedData = try await AuthenticationManager.shared.createUser(email: email,
//                                                                    password: password)
//                print("Success singing in user")
//                print(userReturnedData)
//            }catch{
//                print("Error: \(error)")
//            }
//        }
    }
    func signIn() async throws{
        // Unwrapping the email id and password
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email,
                                                                         password: password)
    }
    
}



struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10.0)
            
            Button{
//                viewModel.signIn()
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    }catch{
                        print(error)
                    }
                    do{
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    }catch{
                        print(error)
                    }
                }
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign in with Email")
    }
}

#Preview {
    NavigationStack{
        SignInEmailView(showSignInView: .constant(false))
    }
}

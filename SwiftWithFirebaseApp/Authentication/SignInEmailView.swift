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
    
    // One way using asynmc throws
//    func signIn() async throws{
    
    
//        let userData = try await AuthenticationManager.shared.createUser(email: email,
//                                                password: password)
//    }
    
    // 2nd  way:  Using Task
    func signIn(){
        // Unwrapping the email id and password
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
            
        Task{
            do{
                let userReturnedData = try await AuthenticationManager.shared.createUser(email: email,
                                                                    password: password)
                print("Success singing in user")
                print(userReturnedData)
            }catch{
                print("Error: \(error)")
            }
                
        }
    }
    
    
}



struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
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
                viewModel.signIn()
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
        SignInEmailView()
    }
}

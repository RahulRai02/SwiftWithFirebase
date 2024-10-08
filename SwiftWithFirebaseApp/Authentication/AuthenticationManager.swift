//
//  AuthenticationManager.swift
//  SwiftWithFirebaseApp
//
//  Created by Rahul Rai on 23/08/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}

final class AuthenticationManager{
    // Singelton
    static let shared = AuthenticationManager()
    
    private init(){ }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String ) async throws ->  AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
    }
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    @discardableResult
    func signInUser(email:String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email,
                                                          password: password)
        let resultUser = AuthDataResultModel(user: authDataResult.user)
        return resultUser
    }
    
}

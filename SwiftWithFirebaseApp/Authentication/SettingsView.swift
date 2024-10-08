//
//  SettingsView.swift
//  SwiftWithFirebaseApp
//
//  Created by Rahul Rai on 26/08/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel : ObservableObject{
    
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
}


struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    }catch{
                        print(error)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack{
        SettingsView(showSignInView: .constant(false))
    }
    
}

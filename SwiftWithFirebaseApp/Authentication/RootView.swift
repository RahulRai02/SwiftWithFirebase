//
//  RootView.swift
//  SwiftWithFirebaseApp
//
//  Created by Rahul Rai on 26/08/24.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack {
            NavigationStack{
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                AuthenticationView()
            }
        }
    }
}

#Preview {
    RootView()
}

//
//  AuthView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 14.05.2024.
//

import SwiftUI

struct AuthView: View {
    @State
    private var currentViewShowing : String = "login"
    
    var body: some View {
        if(currentViewShowing == "login") {
            loginView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.light)
        } else {
            createAccountView(currentShowingView: $currentViewShowing)
                .preferredColorScheme(.dark)
        }
    }
}



//
//  loginView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 14.05.2024.
//

import SwiftUI
import FirebaseAuth

struct loginView: View {
    
    @AppStorage("uid")
    var userId: String = ""
    
    @State
    private var isShowingNameAlert = false
    
    @Binding
    var currentShowingView : String
    @State
    private var email = ""
    
    @State
    private var password = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text("MyGymApp")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Image(systemName: "mail")
                    TextField("Email", text: $email)
                    
                    Spacer()
                    
                    if(email.count != 0) {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("password", text: $password)
                    
                    Spacer()
                    if(password.count != 0) {
                        Image(systemName: password.isValidPassword() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(password.isValidPassword() ? .green : .red)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.black)
                )
                .padding()
                
                Button{
                    withAnimation {
                        self.currentShowingView = "signup"
                    }
                    
                } label: {
                    Text("Dont have an account?")
                        .foregroundColor(.green)
                        .padding()
                        .bold()
                        .font(.title3)
                }
                
                Spacer()
                Spacer()
                
                Button {
                    
                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            isShowingNameAlert = true
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult.user.uid)
                            withAnimation {
                                userId = authResult.user.uid
                            }
                        }
                    }
                    
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(Color.green)
                        .cornerRadius(15)
                        .padding()
                }
                .alert("Try again",isPresented: $isShowingNameAlert) {
                    
                } message: {
                    Text("Invalid email or password")
                }
            }
        }
    }
}

//
//  createAccountView.swift
//  MyGymApp
//
//  Created by Yağız Batu on 14.05.2024.
//

import SwiftUI
import FirebaseAuth

struct createAccountView: View {
    
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
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text("Create an Account")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
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
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Min. 6 Chars, 1 lower, 1 upper, 1 special char", text: $password)
                    
                    Spacer()
                    if(password.count != 0) {
                        Image(systemName: password.isValidPassword() ? "checkmark" : "xmark")
                            .fontWeight(.bold)
                            .foregroundColor(password.isValidPassword() ? .green : .red)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.white)
                )
                .padding()
                
                Button{
                    
                    withAnimation {
                        self.currentShowingView = "login"
                    }
                    
                } label: {
                    Text("Already have account?")
                        .foregroundColor(.green)
                        .padding()
                        .bold()
                        .font(.title3)
                }
                
                Spacer()
                Spacer()
                
                Button {
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let error = error {
                            isShowingNameAlert = true
                            return
                        }
                        
                        if let authResult = authResult {
                            print(authResult)
                            userId = authResult.user.uid
                        }
                    }
                    
                } label: {
                    Text("Create new account")
                        .foregroundColor(.black)
                        .frame(width: 200, height: 40)
                        .background(Color.green)
                        .cornerRadius(15)
                        .padding()
                }
                .alert("Invalid email or password", isPresented: $isShowingNameAlert) {
                    
                } message: {
                    Text("Password must contain minimum of 6 characters, 1 upper, 1 lower and 1 special character")
                }
            }
        }
    }
}

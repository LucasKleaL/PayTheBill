//
//  LoginView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 12/05/22.
//

import SwiftUI
import Firebase
import CommonCrypto

struct LoginView: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    @State var goToHomeView = false
    @State var goToSignUpView = false
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var alertContent = ""
    
    var body: some View {
        
        ZStack {
            
            Color("BackgroundDarkPurple").ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                //Email TextField
                VStack(alignment: .leading) {
                    
                    Text("Email")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    
                    ZStack(alignment: .leading) {
                        if email.isEmpty {
                            Text("Email")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        TextField("", text: $email)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(width: 280, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                    )
                    
                }
                
                //Password TextField
                VStack(alignment: .leading) {
                    
                    Text("Password")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    
                    ZStack(alignment: .leading) {
                        if password.isEmpty {
                            Text("Password")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        SecureField("", text: $password)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(width: 280, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                    )
                    
                }
                
                // Login Button
                NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                    Button {
                        userViewModel.login(email: email, password: password) { result in 
                            if (result == "") {
                                goToHomeView = true;
                            }
                            else {
                                alertContent = result;
                                showAlert.toggle();
                            }
                        }
                    }
                    label : {
                        Text("Log In")
                        Image(systemName: "arrow.forward")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .foregroundColor(Color("InteractionPink"))
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Login Error"),
                            message: Text(alertContent)
                        )
                    }
                }
                
                Spacer()
                
                HStack {
                    
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: SignUpView(), isActive: $goToSignUpView) {
                        Button (action: {
                            goToSignUpView = true
                        }) {
                            Text("Sign Up")
                                .foregroundColor(Color("InteractionPink"))
                        }
                    }
                    
                }
                .padding()
                
                
            }
        }
        
    }
    
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

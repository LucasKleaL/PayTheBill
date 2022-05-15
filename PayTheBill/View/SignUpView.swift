//
//  SignUpView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 12/05/22.
//

import SwiftUI
import Firebase
import CommonCrypto

struct SignUpView: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    //var signInProcessing = true
    @State var goToHomeView = false
    @State var goToLoginView = false
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var retryPassword = ""
    @State var showAlert = false
    @State var alertContent = ""
    
    var body: some View {
        
        ZStack {
            
            Color("BackgroundDarkPurple").ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                //Name TextField
                VStack(alignment: .leading) {
                    
                    Text("Name")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    
                    ZStack(alignment: .leading) {
                        if name.isEmpty {
                            Text("Name")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        TextField("", text: $name)
                    }
                    .frame(width: 280, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                    )
                    
                }
                
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
                
                //Retry Password TextField
                VStack(alignment: .leading) {
                    
                    ZStack(alignment: .leading) {
                        if retryPassword.isEmpty {
                            Text("Retry Password")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        SecureField("", text: $retryPassword)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(width: 280, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                    )
                    
                }
                
                // Sign Up Button
                NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                    Button {
                        userViewModel.signUp(email: email, name: name, password: password, retryPassword: retryPassword) { result in
                            print("result \(result)")
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
                        Text("Sign Up")
                        Image(systemName: "arrow.forward")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .foregroundColor(Color("InteractionPink"))
                    
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Sign Up Error"),
                            message: Text(alertContent)
                        )
                    }
                }
                
                Spacer()
                
                HStack {
                    
                    Text("I already have an account")
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: LoginView(), isActive: $goToLoginView) {
                        Button (action: {
                            goToLoginView = true
                        }) {
                            Text("Log In")
                                .foregroundColor(Color("InteractionPink"))
                        }
                    }
                    
                }
                .padding()
                
                
            }
        }
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

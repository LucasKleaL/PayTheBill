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
    
    var signInProcessing = true
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
                        login()
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
    
    func login() {
        let hashPassword = HashSha256(password)
        Auth.auth().signIn(withEmail: email, password: hashPassword!) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Login Error")
                alertContent = error?.localizedDescription ?? ""
                showAlert.toggle()
            }
            else {
                print("success login")
                goToHomeView = true
            }
        }
    }
    
    func HashSha256(_ string: String) -> String? {
            let length = Int(CC_SHA256_DIGEST_LENGTH)
            var digest = [UInt8](repeating: 0, count: length)

            if let d = string.data(using: String.Encoding.utf8) {
                _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                    CC_SHA256(body, CC_LONG(d.count), &digest)
                }
            }

            return (0..<length).reduce("") {
                $0 + String(format: "%02x", digest[$1])
            }
        }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

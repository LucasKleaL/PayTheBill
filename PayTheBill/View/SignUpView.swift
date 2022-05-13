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
    
    var signInProcessing = true
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
                
                //Retry Password TextField
                VStack(alignment: .leading) {
                    
                    ZStack(alignment: .leading) {
                        if retryPassword.isEmpty {
                            Text("Retry Password")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        SecureField("", text: $retryPassword)
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
                        signUp()
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
    
    func signUp() {
        let hashPassword = HashSha256(password)
        print("hashPassword \(hashPassword!)")
        
        if (password == retryPassword) {
            Auth.auth().createUser(withEmail: email, password: hashPassword!) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "SignUp Error")
                    alertContent = error?.localizedDescription ?? ""
                    showAlert.toggle()
                }
                else {
                    print("success signup")
                    print(Auth.auth().currentUser!.uid)
                    createUserFirestore(userUid: Auth.auth().currentUser!.uid)
                    goToHomeView = true
                }
            }
        }
        else {
            alertContent = "Passwords do not match"
            showAlert.toggle()
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

    func createUserFirestore(userUid: String) {
        let db = Firestore.firestore();
        let docRef = db.collection("Users").document(userUid);
        
        docRef.setData(["name": name]) {error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                print("Document successfully written!")
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

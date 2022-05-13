//
//  ContentView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 03/05/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var goToHomeView = false
    @State var goToLoginView = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color("BackgroundDarkPurple").ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    Image("Bill Minimal Logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Welcome to Pay The Bill!")
                        .padding()
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: LoginView(), isActive: $goToLoginView) {
                        Button {
                            goToLoginView = true
                            login()
                        } label : {
                            Text("Login")
                            Image(systemName: "arrow.forward")
                        }
                        .buttonStyle(.bordered)
                        .padding()
                        .foregroundColor(Color("InteractionPink"))
                    }
                    
                    Spacer()
                    
                }
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            else {
                print("success login")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}

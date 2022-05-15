//
//  ContentView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 03/05/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    @State var goToHomeView = false
    @State var goToLoginView = false
    @State var goToSignupView = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
            
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
                            .frame(width: 60)
                        Image(systemName: "arrow.forward")
                    }
                    .frame(minWidth: 120)
                    .buttonStyle(.bordered)
                    .foregroundColor(Color("InteractionPink"))
                    
                }
                
                NavigationLink(destination: SignUpView(), isActive: $goToSignupView) {
                    Button {
                        goToSignupView = true
                    } label : {
                        Text("Sign Up")
                            .frame(width: 60)
                        Image(systemName: "person.badge.plus")
                    }
                    .frame(minWidth: 120)
                    .buttonStyle(.bordered)
                    .padding(.top, 5)
                    .foregroundColor(Color("InteractionPink"))
                }
                
                Spacer()
                
                NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                    
                }
                
            }.onAppear() {
                userViewModel.getAuthSession() { result in
                    if (result == "") {
                        goToHomeView = true
                    }
                }
            }
            
        }.navigationBarBackButtonHidden(true)
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

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
                    Text("Bem vindo(a) ao Pay The Bill!")
                        .padding()
                    
                    /*
                    Text("Para iniciar, por favor insira seu nome:")
                    TextField("Nome completo", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .frame(width: 280.0, height: 40.0)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                        )
                    */
                    
                    TextField("Email", text: $email)
                        .frame(width: 280.0, height: 40.0)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                        )
                    
                    TextField("Senha", text: $password)
                        .frame(width: 280.0, height: 40.0)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                        )
                    
                    Button {
                        //goToHomeView = true
                        login()
                    } label : {
                        Text("Continuar")
                        Image(systemName: "arrow.forward")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    .foregroundColor(Color("InteractionPink"))
                    
                    Spacer()
                    NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                        
                    }
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

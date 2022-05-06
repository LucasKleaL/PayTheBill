//
//  ContentView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 03/05/22.
//

import SwiftUI

struct ContentView: View {
    
    let aqua = Color("aqua")
    
    @State var goToHomeView = false
    var body: some View {
        
        NavigationView {
            VStack {
                
                Spacer()
                Image("Bill Minimal Logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Bem vindo(a) ao Pay The Bill!")
                    .padding()
                
                Text("Para iniciar, por favor insira seu nome:")
                TextField("Nome completo", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(width: 280.0, height: 40.0)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                    )
                
                Button {
                    goToHomeView = true
                } label : {
                    Text("Continuar")
                    Image(systemName: "arrow.forward")
                }
                
                .buttonStyle(.bordered)
                .padding()
                
                Spacer()
                NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .previewInterfaceOrientation(.portrait)
        }
    }
}

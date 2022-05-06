//
//  AddDashboardView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 03/05/22.
//

import SwiftUI

struct AddDashboardView: View {
    
    @State var goToHomeView = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color("BackgroundDarkPurple").ignoresSafeArea()
                
                // main VStack
                VStack {
                    Spacer()
                    
                    // welcome text VStack
                    VStack {
                        Text("Bem vindo {nome}...")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.all)
                            .frame(width: 300.0)
                            .foregroundColor(.white)
                        Text("Selecione a categoria de conta que você deseja adicionar")
                            .multilineTextAlignment(.leading)
                            .padding(.all)
                            .frame(width: 300.0)
                            .foregroundColor(.white)
                    }
                    
                    // first button cards stack
                    HStack {
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color("CardDarkPurple"))
                            .opacity(0.9)
                            .frame(width: 130, height: 130)
                            .padding(.horizontal)
                            .overlay(
                                VStack {
                                    Image(systemName: "person")
                                        .resizable()
                                        .foregroundColor(Color("InteractionPink"))
                                        .frame(width: 30, height: 30)
                                        
                                    Text("Personal bill")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("InteractionPink"))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        
                                })
            
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color("CardDarkPurple"))
                            .opacity(0.9)
                            .frame(width: 130, height: 130)
                            .overlay(
                                VStack {
                                    Image(systemName: "house")
                                        .resizable()
                                        .foregroundColor(Color("InteractionPink"))
                                        .frame(width: 30, height: 30)
                                        
                                    Text("Home bill")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("InteractionPink"))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        
                                })
                    }
                    
                    // second button cards stack
                    HStack {
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color("CardDarkPurple"))
                            .opacity(0.9)
                            .frame(width: 130, height: 130)
                            .padding(.horizontal)
                            .overlay(
                                VStack {
                                    Image(systemName: "cart")
                                        .resizable()
                                        .foregroundColor(Color("InteractionPink"))
                                        .frame(width: 30, height: 30)
                                        
                                    Text("Purchase bill")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("InteractionPink"))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        
                                })
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color("CardDarkPurple"))
                            .opacity(0.9)
                            .frame(width: 130, height: 130)
                            .overlay(
                                VStack {
                                    Image(systemName: "briefcase")
                                        .resizable()
                                        .foregroundColor(Color("InteractionPink"))
                                        .frame(width: 30, height: 30)
                                        
                                    Text("Work bill")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("InteractionPink"))
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        
                                })
                        
                    }
                    
                    Spacer()
                    
                    // footer component
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .foregroundColor(Color("FooterGray"))
                        .opacity(0.8)
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .overlay(
                            HStack {
                                
                                Button {
                                    goToHomeView = true
                                } label: {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color("DisabledPurple"))
                                }
                                .padding(.horizontal, 20.0)
                                
                                Button {
                                    //action
                                } label: {
                                    Image(systemName: "plus.app.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color("InteractionPink"))
                                }
                                .padding(.horizontal, 20.0)
                                
                                Button {
                                    //action
                                } label: {
                                    Image(systemName: "chart.bar")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color("DisabledPurple"))
                                }
                                .padding(.horizontal, 20.0)
                                
                                Button {
                                    //action
                                } label: {
                                    Image(systemName: "list.dash")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color("DisabledPurple"))
                                }
                                .padding(.horizontal, 20.0)
                                
                            }
                        )
                    NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AddDashboardView()
            .preferredColorScheme(.dark)
    }
}

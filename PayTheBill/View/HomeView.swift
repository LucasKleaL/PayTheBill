//
//  HomeView.swift
//  PayTheBill
//
//  Created by Lucas Leal on 05/05/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var goToAddDashboard = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                Color("BackgroundDarkPurple").ignoresSafeArea()
                
                //main VStack
                VStack {
                    
                    Spacer()
                        
                        // footer component
                        RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .foregroundColor(Color("FooterGray"))
                            .opacity(0.8)
                            .frame(width: UIScreen.main.bounds.width, height: 50)
                            .overlay(
                                HStack {
                                    
                                    Button {
                                        //action
                                    } label: {
                                        Image(systemName: "house.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color("InteractionPink"))
                                    }
                                    .padding(.horizontal, 20.0)
                                    
                                    Button {
                                        goToAddDashboard = true
                                    } label: {
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color("DisabledPurple"))
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
                        
                        NavigationLink(destination: AddDashboardView(), isActive: $goToAddDashboard) {
                            
                        }
                        
                    
                }
                
            }.edgesIgnoringSafeArea(.all)
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

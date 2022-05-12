//
//  AddNewBillView.swift
//  PayTheBill
//
//  Created by Lucas Leal on 05/05/22.
//

import SwiftUI

struct AddNewBillView: View {
    
    @State var goToAddDashboardView = false
    @State var goToHomeView = false
    
    var body: some View {
        ZStack {
            
            Color("BackgroundDarkPurple").ignoresSafeArea()
            
            //main VStack
            VStack {
                
                Spacer()
                
                Text("Add a new Bill")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.all)
                    .frame(width: 300.0)
                    .foregroundColor(.white)
                
                Spacer()
                    
                    // footer component
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .foregroundColor(Color("FooterGray"))
                        .opacity(0.8)
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .overlay(
                            HStack {
                                
                                NavigationLink(destination: HomeView(), isActive: $goToHomeView) {
                                    Button {
                                        goToHomeView = true
                                    } label: {
                                        Image(systemName: "house.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color("DisabledPurple"))
                                    }
                                    .padding(.horizontal, 20.0)
                                }
                                
                                NavigationLink(destination: AddDashboardView(), isActive: $goToAddDashboardView) {
                                    Button {
                                        goToAddDashboardView = true
                                    } label: {
                                        Image(systemName: "plus.app.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color("InteractionPink"))
                                    }
                                    .padding(.horizontal, 20.0)
                                }
                                
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
            }
        }.edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
            
        
    }
}

struct AddNewBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBillView()
    }
}

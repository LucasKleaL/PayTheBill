//
//  AddDashboardView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 03/05/22.
//

import SwiftUI
import Firebase

struct AddDashboardView: View {
    
    @State var goToHomeView = false
    @State var goToAddNewBillView = false
    @State var currentDisplayName = "";
    
    var body: some View {
        
        
            
            ZStack {
                
                Color("BackgroundDarkPurple").ignoresSafeArea()
                
                // main VStack
                VStack {
                    Spacer()
                    
                    // welcome text VStack
                    VStack {
                        Text("What's up \(currentDisplayName)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            .frame(width: 300.0)
                            .foregroundColor(.white)
                            .onAppear() {
                                currentDisplayName = Auth.auth().currentUser!.displayName ?? "";
                            }
                        Text("What is the Bill?")
                            //.multilineTextAlignment(.leading)
                            .padding(.all)
                            .frame(width: 300.0)
                            .foregroundColor(.white)
                    }
                    
                    // first button cards stack
                    HStack {
                        
                        NavigationLink(destination: AddNewBillView(billCategory: "Personal"), isActive: $goToAddNewBillView) {
                            Button {
                                goToAddNewBillView = true;
                            } label: {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color("CardDarkPurple"))
                                    .opacity(0.9)
                                    .frame(width: 130, height: 130)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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
                            }
                        }
                        
                        NavigationLink(destination: AddNewBillView(billCategory: "House"), isActive: $goToAddNewBillView) {
                            Button {
                                goToAddNewBillView = true;
                            } label: {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color("CardDarkPurple"))
                                    .opacity(0.9)
                                    .frame(width: 130, height: 130)
                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
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
                        }
                        
                    }
                    
                    // second button cards stack
                    HStack {
                        
                        NavigationLink(destination: AddNewBillView(billCategory: "Purshase"), isActive: $goToAddNewBillView) {
                            Button {
                                goToAddNewBillView = true;
                            } label : {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color("CardDarkPurple"))
                                    .opacity(0.9)
                                    .frame(width: 130, height: 130)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
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
                            }
                        }
                        
                        NavigationLink(destination: AddNewBillView(billCategory: "Work"), isActive: $goToAddNewBillView) {
                            Button {
                                goToAddNewBillView = true;
                            } label: {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color("CardDarkPurple"))
                                    .opacity(0.9)
                                    .frame(width: 130, height: 130)
                                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 0, trailing: 0))
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
                        }
                        
                    }
                    
                    Spacer()
                    
                    // footer component
                    FooterView(currentPage: "add")
                    
                }

            }.edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AddDashboardView()
            .preferredColorScheme(.dark)
    }
}

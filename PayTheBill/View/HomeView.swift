//
//  HomeView.swift
//  PayTheBill
//
//  Created by Lucas Leal on 05/05/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    @State var goToAddDashboard = false;
    @State var goToContentView = false;
    @State var currentUserName = "";
    @State var currentUserBills = [];
    let db = Firestore.firestore();
    
    var body: some View {
            
            ZStack {
                
                Color("BackgroundDarkPurple").ignoresSafeArea()
                
                //main VStack
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Hello "+currentUserName)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.all)
                                .frame(width: 300.0)
                                .foregroundColor(.white)
                            NavigationLink (destination: ContentView(), isActive: $goToContentView) {
                                Button {
                                    userViewModel.signOut() { result in
                                        if (result == "") {
                                            goToContentView = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .onAppear() {
                        self.userViewModel.fetchUser() { user in
                            self.currentUserName = user.userName!;
                            print("appear "+user.userName!)
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("InteractionPink"))
                        .opacity(0.5)
                        .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), height: 100)
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
                                
                                NavigationLink(destination: AddDashboardView(), isActive: $goToAddDashboard) {
                                    Button {
                                        goToAddDashboard = true
                                    } label: {
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color("DisabledPurple"))
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
            .onAppear {
                //
            }
    }
    
    func calculatePercentage(value: CGFloat, percentVal: CGFloat) -> CGFloat {
        let val = value * percentVal;
        return CGFloat(val / 100.0)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//
//  HomeView.swift
//  PayTheBill
//
//  Created by Lucas Leal on 05/05/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @ObservedObject var userViewModel = UserViewModel();
    @ObservedObject var billViewModel = BillViewModel();
    @State var goToAddDashboard = false;
    @State var goToContentView = false;
    @State var goToListView = false;
    @State var currentUserName = "";
    @State var currentUserBills = [];
    @State var userActiveBills = 0;
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
                        .onAppear() {
                            userViewModel.fetchUser() { user in
                                currentUserBills = user.userBills ?? [""]
                            }
                            billViewModel.fetchBills() { result in }
                        }
                        .overlay(
                            VStack() {
                                
                                Spacer()
                                
                                Text("You has \(currentUserBills.count ?? [""].count) active bills.")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                NavigationLink(destination: ListView(), isActive: $goToListView) {
                                    Button {
                                        goToListView = true;
                                    } label: {
                                        Text("View all bills")
                                            .underline()
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                Spacer()
                            }
                        )
                    
                    Spacer()
                    
                    // footer component
                    FooterView(currentPage: "home")
                    
                }
            }.edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(.stack)
            .onAppear {
                //
                billViewModel.fetchBills() { bill in }
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

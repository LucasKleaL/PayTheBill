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
    @State var bills = [BillModel()];
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
                        .onAppear() {
                            billViewModel.fetchBills() { result in
                                self.bills = result;
                                print("bill fetch \(self.bills)")
                            }
                            
                        }
                    
                    VStack {
                        ForEach(0..<self.bills.count) { index in
                            Text("\(self.bills.count)")
                                .foregroundColor(.white)
                            Text(self.bills[index].billOwner as? String ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.all)
                                .frame(width: 300.0)
                                .foregroundColor(.white)

                                Text(self.bills[index].billOwner as? String ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.all)
                                    .frame(width: 300.0)
                                    .foregroundColor(.white)
                        }

                    }
                    
                    Spacer()
                    
                    // footer component
                    FooterView(currentPage: "home")
                    
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

//
//  HomeView.swift
//  PayTheBill
//
//  Created by Lucas Leal on 05/05/22.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @State var goToAddDashboard = false;
    @State var userName: String = "";
    @State var user = [String: Any]();
    let db = Firestore.firestore();
    
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
                getUserData()
            }
    }
    
    func getUserData() {
        let docRef = db.collection("Users").document(Auth.auth().currentUser!.uid)

        docRef.getDocument{ (document, error) in
            
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data["name"]!)
                    print("data type ", type(of: data["name"]))
                    //$userName! = String(data["name"]) as? String ?? ""
                }
            }
            
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

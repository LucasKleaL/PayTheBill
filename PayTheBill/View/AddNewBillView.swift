//
//  AddNewBillView.swift
//  PayTheBill
//
//  Created by Lucas Leal on 05/05/22.
//

import SwiftUI

struct AddNewBillView: View {
    
    @ObservedObject var userViewModel = UserViewModel();
    @ObservedObject var billViewModel = BillViewModel();
    @State var goToAddDashboardView = false;
    @State var goToHomeView = false;
    @State var showAlert = false;
    @State var alertContent = "";
    @State var userUid = "";
    @State var userName = "";
    @State var billOwner = "";
    @State var billCategory: String?;
    @State var title = "";
    @State var desc = "";
    @State var value: Float = 0.0;
    //@State var payedValue: Float = 0.0;
    @State var parcels: Int = 0;
    //@State var creationDate = "";
    //@State var finishDate = "";
    
    init(billCategory: String) {
        self._billCategory = State(initialValue: billCategory);
    }
    
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
                
                VStack (alignment: .leading) {
                    Text("From "+userName)
                        .onAppear() {
                            self.userViewModel.fetchUser() { user in
                                self.userUid = user.userUid!;
                                self.userName = user.userName!;
                            }
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    HStack () {
                        Text("To ")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(width: 30, height: 40)
                        
                        VStack(alignment: .leading) {
                                                        
                            ZStack(alignment: .leading) {
                                if billOwner.isEmpty {
                                    Text("Name")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                TextField("", text: $billOwner)
                                    .textInputAutocapitalization(.never)
                            }
                            .frame(width: 240, height: 40)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.white)
                            )
                            
                        }
                    }
                }
                
                //Bill Title TextField
                VStack(alignment: .leading) {
                    
                    Text("Bill Title")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    
                    ZStack(alignment: .leading) {
                        if title.isEmpty {
                            Text("Title")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        TextField("", text: $title)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(width: 280, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                    )
                    
                }
                
                //Bill Desc TextField
                VStack(alignment: .leading) {
                    
                    Text("Bill Description")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    
                    ZStack(alignment: .leading) {
                        if desc.isEmpty {
                            Text("Description")
                                .foregroundColor(.white.opacity(0.5))
                        }
                        TextField("", text: $desc)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(width: 280, height: 40)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.white)
                    )
                    
                }
                
                //Bill value and parcel
                HStack {
                    //Bill Value TextField
                    VStack(alignment: .leading) {
                        
                        Text("Bill Value")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                        
                        ZStack(alignment: .leading) {
                            TextField("", value: $value, formatter: NumberFormatter())
                                .textInputAutocapitalization(.never)
                        }
                        .frame(width: 130, height: 40)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.white)
                        )
                        
                    }
                    
                    //Bill Parcel TextField
                    VStack(alignment: .leading) {
                        
                        Text("Number of Parcels")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                        
                        ZStack(alignment: .leading) {
                            TextField("", value: $parcels, formatter: NumberFormatter())
                                .textInputAutocapitalization(.never)
                                .keyboardType(UIKeyboardType.decimalPad)
                        }
                        .frame(width: 130, height: 40)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.white)
                        )
                        
                    }
                }
                
                HStack {
                    NavigationLink(destination: AddDashboardView(), isActive: $goToAddDashboardView) {
                        Button {
                            goToAddDashboardView = true;
                        } label : {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                            .buttonStyle(.bordered)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        billViewModel.addBill(userUid: self.userUid, billOwner: self.billOwner, billCategory: self.billCategory!, title: self.title, desc: self.desc, value: self.value, parcels: self.parcels) { result in
                            print("confirm result "+result);
                            self.alertContent = result;
                            self.showAlert.toggle();
                        }
                    } label : {
                        Text("Confirm")
                        //Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 0))
                    .foregroundColor(Color("InteractionPink"))
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Add New Bill Result"),
                            message: Text(alertContent),
                            dismissButton: .default(Text("Ok")) {
                                if (alertContent == "Bill successfully added.") {
                                    goToAddDashboardView = true;
                                }
                            }
                        )
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

struct AddNewBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBillView(billCategory: "")
    }
}

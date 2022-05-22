//
//  ListView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 21/05/22.
//

import SwiftUI
import Firebase

struct ListView: View {
    
    @ObservedObject var billViewModel = BillViewModel();
    @State var currentDisplayName = "";
    @State var billTitleIcon = "person";
    
    var body: some View {
        ZStack {
            
            Color("BackgroundDarkPurple").ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                ForEach(billViewModel.currentUserBills, id: \.uid) { bill in
                    
                    if (bill.userUid == Auth.auth().currentUser!.uid) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color("InteractionPink"))
                            .opacity(0.2)
                            .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), height: 200)
                            .overlay (
                                VStack {
                                    
                                    HStack {
                                        
                                        Text(bill.title ?? "")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                        
                                        Image(systemName: "person")
                                            
                                        /*
                                            .onAppear() {
                                                self.setBillCategoryIcon(category: bill.billCategory ?? "");
                                                /*
                                                if (bill.billCategory == "Personal") {
                                                    self.billTitleIcon = "person";
                                                }
                                                else if (bill.billCategory == "Home") {
                                                    self.billTitleIcon = "house";
                                                }
                                                else if (bill.billCategory == "Purchase") {
                                                    self.billTitleIcon = "cart";
                                                }
                                                else if (bill.billCategory == "Work") {
                                                    self.billTitleIcon = "briefCase";
                                                }
                                                else {
                                                    print("No category found")
                                                }
                                                */
                                            }
                                         */
                                            
                                            .resizable()
                                            .foregroundColor(Color("InteractionPink"))
                                            .frame(width: 18, height: 18)
                                        
                                    }
                                    .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), alignment: .leading)
                                    .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 0))
                                    
                                    Text(bill.desc ?? "")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), alignment: .leading)
                                        .padding(EdgeInsets(top: 1, leading: 30, bottom: 0, trailing: 0))
                                    
                                    Text("From \(currentDisplayName) to \(bill.billOwner ?? ""), \(bill.creationDate ?? "")")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), alignment: .leading)
                                        .padding(EdgeInsets(top: 1, leading: 30, bottom: 0, trailing: 0))
                                    
                                    let billValue = String(format: "%.1f", bill.value!);
                                    let payedValue = String(format: "%.1f", bill.payedValue!);
                                    
                                    Text("Value \(billValue), Payed: \(payedValue)")
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), alignment: .leading)
                                        .padding(EdgeInsets(top: 1, leading: 30, bottom: 5, trailing: 0))
                                    
                                    Button {
                                        
                                    } label : {
                                        Text("Pay Bill")
                                        Image(systemName: "dollarsign.circle")
                                    }
                                    .buttonStyle(.bordered)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .foregroundColor(Color("InteractionPink"))
                                    
                                }
                            )
                    }
                    
                }
                
                Spacer()
                
                FooterView(currentPage: "list")
                
            }
            
            
            
        }.edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            currentDisplayName = Auth.auth().currentUser!.displayName ?? "";
            billViewModel.fetchBills() { result in }
        }
    }
    
    func calculatePercentage(value: CGFloat, percentVal: CGFloat) -> CGFloat {
        let val = value * percentVal;
        return CGFloat(val / 100.0)
    }
    
    func setBillCategoryIcon(category: String) -> String {
        print("category \(category)")
        if (category == "Personal") {
            return "person";
        }
        else if (category == "Home") {
            print("house")
            self.billTitleIcon = "house";
            return "house";
        }
        else if (category == "Purchase") {
            return "cart";
        }
        else if (category == "Work") {
            return "briefCase";
        }
        else {
            return "";
        }
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

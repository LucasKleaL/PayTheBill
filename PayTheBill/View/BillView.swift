//
//  BillView.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 21/05/22.
//

import SwiftUI
import Firebase

struct BillView: View {
    
    @ObservedObject var billViewModel = BillViewModel();
    @State var uid: String;
    @State var userName: String?;
    @State var user = UserModel();
    @State var bill = BillModel();
    @State var sliderValue: Float = 0;
    @State var goToListView = false;
    
    var body: some View {
        ZStack {
            Color("BackgroundDarkPurple").ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("InteractionPink"), lineWidth: 5)
                    .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 90), height: calculatePercentage(value: UIScreen.main.bounds.height, percentVal: 70))
                    .overlay (
                        
                        VStack {
                            
                            Spacer()
                            
                            Text(self.bill.title ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text(self.bill.desc ?? "")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            
                            Text("From \(self.userName ?? "") to \(self.bill.billOwner ?? "")")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                            
                            let billValue = String(format: "%.2f", self.bill.value!);
                            let payedValue = String(format: "%.2f", self.bill.payedValue!);
                            
                            VStack {
                                Text(billValue)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                Slider(value: $sliderValue, in: Float(payedValue)!...Float(billValue)!, step: 0.1)
                                    .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 60))
                                Text("\(String(format: "%.2f", sliderValue))")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: ListView(), isActive: ($goToListView)) {
                                
                                Button {
                                    goToListView = true;
                                } label : {
                                    Text("Back")
                                }
                                    .buttonStyle(.bordered)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .foregroundColor(.white)
                                
                                Button {
                                    self.billViewModel.updateBillPayedValue(uid: self.uid, payedValue: self.sliderValue) { result in
                                        if (result == "") {
                                            goToListView = true;
                                        }
                                    }
                                } label : {
                                    Text("Save")
                                }
                                    .buttonStyle(.bordered)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .foregroundColor(Color("InteractionPink"))
    
                            }
                            
                            Spacer()
                            
                        }
                        
                    )
                Text(self.uid)
                
                Spacer()
                
                FooterView(currentPage: "list")
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        .edgesIgnoringSafeArea(.all)
    }
                
    func calculatePercentage(value: CGFloat, percentVal: CGFloat) -> CGFloat {
        let val = value * percentVal;
        return CGFloat(val / 100.0)
    }
                
}

struct BillView_Previews: PreviewProvider {
    static var previews: some View {
        BillView(uid: "", bill: BillModel())
    }
}

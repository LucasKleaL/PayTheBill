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
    @State var checkbox = false;
    @State var showAlert = false;
    @State var alertContent = "";
    
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
                            
                            Image(systemName: "checkmark.square")
                                .foregroundColor(checkbox ? Color("InteractionPink") : Color("BackgroundDarkPurple"))
                                .font(.system(size: 50))
                                .multilineTextAlignment(.trailing)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                                .onAppear() {
                                    if (self.bill.payedValue! == self.bill.value!) {
                                        self.checkbox = true;
                                    }
                                }
                             
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
                                
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30))
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    Text(billValue)
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                }
                                
                                if (billValue != payedValue) {
                                    Slider(value: $sliderValue, in: Float(payedValue)!...Float(billValue)!, step: 0.01)
                                        .frame(width: calculatePercentage(value: UIScreen.main.bounds.width, percentVal: 60))
                                        .onAppear() {
                                            sliderValue = Float(payedValue)!;
                                        }
                                    HStack {
                                        Image(systemName: "dollarsign.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                        Text("\(String(format: "%.2f", sliderValue))")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    }
                                }
                                else {
                                    HStack {
                                        Image(systemName: "dollarsign.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 30))
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                        Text("\(String(format: "%.2f", self.bill.payedValue!))")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    }
                                }
                                
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: ListView(), isActive: ($goToListView)) {
                                
                                Button {
                                    goToListView = true;
                                } label : {
                                    Image(systemName: "arrow.left")
                                    Text("Back")
                                }
                                    .buttonStyle(.bordered)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .foregroundColor(.white)
                                
                                Button {
                                    self.billViewModel.updateBillPayedValue(uid: self.uid, payedValue: self.sliderValue, billValue: self.bill.value!) { result in
                                        if (result == "") {
                                            if (self.sliderValue == self.bill.value!) {
                                                self.checkbox = true;
                                            }
                                            //goToListView = true;
                                        }
                                        
                                    }
                                    
                                } label : {
                                    Text("Save")
                                    Image(systemName: "arrow.forward")
                                }
                                    .buttonStyle(.bordered)
                                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    .foregroundColor(Color("InteractionPink"))
    
                            }
                            
                            Spacer()
                            
                            Button {
                                billViewModel.deleteBill(billUid: self.uid, finishDate: self.bill.finishDate!) { result in
                                    if (result != "") {
                                        self.alertContent = result;
                                        self.showAlert = true;
                                    }
                                    else {
                                        self.alertContent = "Bill successfully deleted.";
                                        self.showAlert = true;
                                    }
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .foregroundColor(Color("InteractionPink"))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                            }.alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Delete Bill Result"),
                                    message: Text(self.alertContent),
                                    dismissButton: .default(Text("Ok")) {
                                        if (self.alertContent == "Bill successfully deleted.") {
                                            goToListView = true;
                                        }
                                    }
                                )
                            }
                            
                        }
                        
                    )
                
                Text(self.uid)
                    .font(.system(size: 11))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                FooterView(currentPage: "list")
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        //.navigationViewStyle(.stack)
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

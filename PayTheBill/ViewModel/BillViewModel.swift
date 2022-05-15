//
//  BillViewModel.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 15/05/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class BillViewModel: ObservableObject {
    @Published var bill = BillModel();
    @Published var bills = [BillModel()];
    private var db = Firestore.firestore();
    
    func addBill(userUid: String, billOwner: String, billCategory: String, title: String, desc: String, value: Float, parcels: Int, completion: @escaping(String) -> Void) {
        let docRef = db.collection("Bills").document();
        
        let datetime = Date();
        let format = DateFormatter();
        format.timeZone = .current;
        format.dateFormat = "yyyy-MM-dd' 'HH:mm";
        let creationDate = format.string(from: datetime);
        
        print("datetime \(creationDate)");
        
        docRef.setData(
            [
                "userUid": userUid,
                "billOwner": billOwner,
                "billCategory": billCategory,
                "title": title,
                "desc": desc,
                "value": value,
                "payedValue": 0.0,
                "parcels": parcels,
                "creationDate": creationDate,
                "finishDate": ""
            ]
        ) { error in
            if let error = error {
                print("Error writing addBill document: \(error)");
                completion("\(error)");
            }
            else {
                print("AddBill document successfully written!")
                completion("Bill successfully added.")
            }
        }
    }
    
    
    
}

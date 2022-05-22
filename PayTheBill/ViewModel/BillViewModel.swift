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
    
    var userViewModel = UserViewModel()
    @Published var bill = BillModel();
    @Published var bills = [BillModel()];
    @Published var currentUserBills = [BillModel()];
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
                self.sendBillToUser(userUid: userUid, billUid: docRef.documentID) { result in
                    
                }
                completion("Bill successfully added.")
            }
        }
    }
    
    func sendBillToUser(userUid: String, billUid: String, completion: @escaping(String) -> Void) {
        let docRef = db.collection("Users").document(userUid);
        var userBills = [""];
        
        //Getting user data
        userViewModel.fetchUser() { user in
            userBills = user.userBills!
            //If the first position is a null string, removes the value from bill's array
            if (userBills.count != 0 && userBills[0] == "") {
                print("removing the position 0 of bills")
                userBills.remove(at: 0)
            }
            userBills.append(billUid);
            
            //Adding the bill into user document
            docRef.updateData(["bills": userBills]) {error in
                if let error = error {
                    print("Error writing bill to user document: \(error)")
                    completion("Error writing bill to user document: \(error)");
                }
                else {
                    print("Send Bill To User Document successfully written!")
                    completion("");
                }
            }
        }
        
    }
    
    func fetchBill(uid: String, completion: @escaping(BillModel) -> Void) {
        db.collection("Users").document(uid)
            .getDocument { (document, error) in
                //let data = document!.data();
                let uid = document!.documentID;
                let userUid = document!.data()!["userUid"] as? String ?? "";
                let billOwner = document!.data()!["billOwner"] as? String ?? "";
                let billCategory = document!.data()!["billCategory"] as? String ?? "";
                let title = document!.data()!["title"] as? String ?? "";
                let desc = document!.data()!["desc"] as? String ?? "";
                let value = document!.data()!["value"] as? Float ?? 0.0;
                let payedValue = document!.data()!["payedValue"] as? Float ?? 0.0;
                let parcels = document!.data()!["parcels"] as? Int ?? 0;
                let creationDate = document!.data()!["creationDate"] as? String ?? "";
                let finishDate = document!.data()!["finishDate"] as? String ?? "";
                
                print("fetchBill uid \(uid)")
                self.bill = BillModel(id: .init(), uid: uid, userUid: userUid, billOwner: billOwner, billCategory: billCategory, title: title, desc: desc, value: value, payedValue: payedValue, parcels: parcels, creationDate: creationDate, finishDate: finishDate);
                completion(self.bill);
                /*
                self.user = UserModel(id: .init(), userUid: userUid, userName: userName, userBills: userBills);
                completion(self.user);
                */
            }
        print("fetchBill \(self.bill)")
    }
    
    func fetchBills(completion: @escaping([BillModel]) -> Void) {
        db.collection("Bills").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Users documents")
                return
            }
            
            self.bills = documents.map { queryDocumentSnapshot -> BillModel in
                let data = queryDocumentSnapshot.data();
                let uid = queryDocumentSnapshot.documentID;
                let userUid = data["userUid"] as? String ?? "";
                let billOwner = data["billOwner"] as? String ?? "";
                let billCategory = data["billCategory"] as? String ?? "";
                let title = data["title"] as? String ?? "";
                let desc = data["desc"] as? String ?? "";
                let value = data["value"] as? Float ?? 0.0;
                let payedValue = data["payedValue"] as? Float ?? 0.0;
                let parcels = data["parcels"] as? Int ?? 0;
                let creationDate = data["creationDate"] as? String ?? "";
                let finishDate = data["finishDate"] as? String ?? "";
                
                print("fetchBills")
                return(BillModel(
                    id: .init(),
                    uid: uid,
                    userUid: userUid,
                    billOwner: billOwner,
                    billCategory: billCategory,
                    title: title,
                    desc: desc,
                    value: value,
                    payedValue: payedValue,
                    parcels: parcels,
                    creationDate: creationDate,
                    finishDate: finishDate
                ));
                
            }
            completion(self.bills)
            self.fetchCurrentUserBills() { result in }
        }
    }
    
    func fetchCurrentUserBills(completion: @escaping([BillModel]) -> Void) {
        self.bills.map { document in
            print("fetchCurrentUser \(document)")
            if (document.userUid == Auth.auth().currentUser!.uid) {
                self.currentUserBills.append(document);
            }
        }
    }
    
    func updateBillPayedValue(uid: String, payedValue: Float, completion: @escaping(String) -> Void) {
        let docRef = db.collection("Bills").document(uid);
        
        docRef.updateData(["payedValue": payedValue]) {error in
            if let error = error {
                print("Error updating bill payed value document: \(error)")
                completion("Error writing bill to user document: \(error)");
            }
            else {
                print("Sucessfully update bill document with payed value.")
                completion("");
            }
        }
    }
    
}

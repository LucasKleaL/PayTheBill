//
//  UserViewModel.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 13/05/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user = [UserModel]()
    private var db = Firestore.firestore()
    
    func fetchUser() {
        db.collection("Users").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Users documents")
                return
            }
            
            self.user = documents.map { queryDocumentSnapshot -> UserModel in
                let data = queryDocumentSnapshot.data()
                let userUid = Auth.auth().currentUser!.uid
                let userName = data["name"] as? String ?? ""
                
                return(UserModel(id: .init(), userUid: userUid, userName: userName))
            }
        }
    }
}

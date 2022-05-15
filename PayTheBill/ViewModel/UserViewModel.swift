//
//  UserViewModel.swift
//  PayTheBill
//
//  Created by Lucas Kusman Leal on 13/05/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import CommonCrypto

class UserViewModel: ObservableObject {
    @Published var users = [UserModel]();
    @Published var user = UserModel();
    private var db = Firestore.firestore();
    
    func fetchUser(completion: @escaping(UserModel) -> Void) { //closure instead of return
        db.collection("Users").document(Auth.auth().currentUser!.uid)
            .getDocument { (document, error) in
                let userUid = document!.documentID;
                let userName = document!.data()!["name"] as? String ?? "";
                self.user = UserModel(id: .init(), userUid: userUid, userName: userName)
                completion(self.user);
            }
    }
    
    func fetchUsers() {
        db.collection("Users").addSnapshotListener{ querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Users documents")
                return
            }
            
            self.users = documents.map { queryDocumentSnapshot -> UserModel in
                let data = queryDocumentSnapshot.data();
                let userUid = queryDocumentSnapshot.documentID;
                let userName = data["name"] as? String ?? "";
                let userBills = data["bills"] as? Array<String> ?? [""];
                print("Document UserUid: "+userUid);
                print("userBills: \(userBills)");
                
                return(UserModel(id: .init(), userUid: userUid, userName: userName, userBills: userBills))
            }
        }
    }
    
    func signUp(email: String, name: String, password: String, retryPassword: String, completion: @escaping(String) -> Void ) {
        let hashPassword = HashSha256(password)
        print("hashPassword \(hashPassword!)")
        
        if (password.count >= 4) { //Password min lenght verification
            if (password == retryPassword) { //Password match verification
                Auth.auth().createUser(withEmail: email, password: hashPassword!) { (result, error) in
                    if error != nil {
                        print("Auth error != nil")
                        print(error?.localizedDescription ?? "SignUp Error")
                        completion(error?.localizedDescription as? String ?? "SignUpError");
                    }
                    else {
                        print("success signup")
                        print(Auth.auth().currentUser!.uid)
                        self.createUserFirestore(userUid: Auth.auth().currentUser!.uid, name: name)
                        completion("")
                    }
                }
            }
            else {
                completion("Passwords do not match");
            }
        }
        else {
            completion("Password must have a minimum of 4 characters")
        }
    }
    
    func HashSha256(_ string: String) -> String? {
        let length = Int(CC_SHA256_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_SHA256(body, CC_LONG(d.count), &digest)
            }
        }

        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }

    func createUserFirestore(userUid: String, name: String) {
        let db = Firestore.firestore();
        let docRef = db.collection("Users").document(userUid);
        
        //Adding the display name to the created user
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            print("Error commiting the user displayName \(String(describing: error))")
        }
        
        docRef.setData(["name": name, "bills": [""]]) {error in
            if let error = error {
                print("Error writing document: \(error)")
                //completation(false);
            }
            else {
                print("Document successfully written!")
                //completation(true);
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping(String) -> Void) {
        let hashPassword = HashSha256(password)
        Auth.auth().signIn(withEmail: email, password: hashPassword!) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Login Error")
                completion(error?.localizedDescription ?? "Login Error")
            }
            else {
                print("Successful login")
                completion("")
            }
        }
    }
    
    func signOut(completion: @escaping(String) -> Void) {
        do {
            try Auth.auth().signOut()
            completion("")
        }
        catch {
            print("Error while signing out.")
            completion("Error while signing out")
        }
    }
    
    func getAuthSession(completion: @escaping(String) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                print("User session signed in");
                completion("");
                // User is signed in.
            }
            else {
                print("No user session signed in");
                completion("No user session signed in");
                // No user is signed in.
            }
        }
    }
    
    
    
}

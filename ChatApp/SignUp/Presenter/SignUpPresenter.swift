//
//  SignUpPresenter.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import Foundation
import Firebase

protocol SignUpView {
    func successfullySignedUp()
    func failedSignedUp()
}


class SignUpPresenter {
    
    //MARK:- Properties
    var view: SignUpView?
    
    
    //MARK:- Init
    init(view: SignUpView) {
        self.view = view
    }
    
    //MARK:- Methods
    
    func signUp(email: String, password: String, username: String) {
        
         Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let er = err {
                // View error
                self.view?.failedSignedUp()
                print("error while signed Up \(er)")
            }else {
                print(result?.user)
                guard let userID = Auth.auth().currentUser?.uid else {return}
                let db = Database.database().reference()
                let dict: [String: Any] = [
                    "username": username,
                    "email": email,
                    "userID": userID
                ]
                db.child("users").child(userID).setValue(dict)
                print("User has signed Up successfully")
                self.view?.successfullySignedUp()
                
            }
        }
    }
    

}

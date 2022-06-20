//
//  UserPresenter.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import Foundation
import Firebase

//MARK:- Protocol

protocol UsersView {
    func userDidLoad(users: UsersModel)
    func emptyArr()
}

//MARK:- Presenter
class UsersPresenter {
    //MARK:- Properties
    var view: UsersView?
    var db = Database.database().reference()
    
    //MARK:- Init
    init(view: UsersView) {
        self.view = view
    }
    //MARK:- Methods
    
    func loadKeys() {
        // KEYSSSS Remember to extract the keys so you can make another request with users keys
        
        db.child("users").getData { (err, datasnapshot) in
            if let error = err {
                print("Error \(error)")
            }else {
                guard let values = datasnapshot?.value as? NSDictionary else {return}
                let arrID = values.allKeys as! [String]
                self.loadusers(ids: arrID)
            }
        }
        
    }
    
    func loadusers(ids: [String]) {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        for id in ids {
            if id != userID  {
                db.child("users").child(id).observe(.value) { (dataSnapshot) in
                    guard let value = dataSnapshot.value as? NSDictionary else {return}
                    let email    = value["email"] as? String
                    let userID   = value["userID"] as? String
                    let username = value["username"] as? String
                    let users = UsersModel(email: email, userID: userID, username: username)
                    self.view?.userDidLoad(users: users)
                }
            }
        }        
    }
    // Load Users
    
}

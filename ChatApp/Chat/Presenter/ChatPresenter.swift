//
//  ChatPresenter.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import Foundation
import Firebase

//MARK:- Protocol

protocol ChatView {
    func messageSent()
    func messageLoaded()
}
//MARK:- Presenter
class ChatPresenter {
    
    //MARK:- Properties
    var view: ChatView?
    let db = Database.database().reference()
    let ref = Firestore.firestore()
    
    //MARK:- Init
    init(view: ChatView) {
        self.view = view
    }
    

    //MARK:- Load Messages
    func loadKeys() {
        
        db.child("users").getData { (err, dataSnapshot) in
            if let error = err {
                print("error \(error)")
            }else {
                guard let values = dataSnapshot?.value as? NSDictionary else {return}
                guard let ids    = values.allKeys as? [String] else {return}
                self.loadMessages()
            }
        }
    }
    
    
    func loadMessages() {
        print("Load Messages..")
        ref.collection("messages").addSnapshotListener { (querySnapshot, err) in
            if let error = err {
                print("\(error)")
            }else{
                if let docs = querySnapshot?.documents {
                    for doc in docs {
                        let data = doc.data()
                        print(data)
                    }
                }
            }
        }
    }
    
    //MARK:- Send Message
    func sendMessage(txt: String, toID: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let date = "\(Date())"
        let values: [String : Any] = [
        "fromID": userID,
        "toID"  : toID,
        "mssg"  : txt,
        "time"  : date
    ]
        ref.collection("messages").document().setData(values)
        self.view?.messageSent()
    }
    
}

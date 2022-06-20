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
    func emptyArr()
    func messageSent()
    func messageLoaded(messages: MessageModel)
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
            }
        }
    }
    
    
    func loadMessages() {
        print("Load Messages..")
        ref.collection("messages").addSnapshotListener { (querySnapshot, err) in
            if let error = err {
                print("\(error)")
            }else{
                // Empty the array
                self.view?.emptyArr()
                if let docs = querySnapshot?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let mssg = data["mssg"] as? String
                        let to   = data["toID"] as? String
                        let from = data["fromID"] as? String
                        let time = data["time"] as? String
                        
                        let message = MessageModel(fromID: from, toID: to, messageContent: mssg, time: time)
                        self.view?.messageLoaded(messages: message)

                        print(data)
                    }
                }
            }
        }
    }
    
    /*
     
     ["mssg": Hello Theresa! How’s it going?, "fromID": Ii5lWJ1GltWILWEm69R6gsB4oCN2, "time": 2022-06-20 21:33:21 +0000, "toID": pKRuPUzQZsWBdxTqyOzE3TNrDch1]
    */
    
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

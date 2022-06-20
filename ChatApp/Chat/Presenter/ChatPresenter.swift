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
    func messageLoaded()
}
//MARK:- Presenter
class ChatPresenter {
    
    //MARK:- Properties
    var view: ChatView?
    
    
    //MARK:- Init
    init(view: ChatView) {
        self.view = view
    }
    

    //MARK:- Load Messages
    func loadMessages(id: String) {
        // UserID is the current ID     fromID
        // id is the receiver ID        toID
//        guard let userID = Auth.auth().currentUser?.uid else { return }
//        let db = Database.database().reference()
        // Load Message and append them to the message Model
    }
    
    //MARK:- Send Message
    func sendMessage(txt: String, toID: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Database.database().reference()
        
        db.child("messages").setValue([
            "fromID": userID,
            "toID": toID,
            "mssg": txt
        ])
        
    }
    
}

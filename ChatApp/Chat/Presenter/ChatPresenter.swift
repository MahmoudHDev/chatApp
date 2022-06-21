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
    
    func loadMessages(id: String) {
        
        guard let fromID = Auth.auth().currentUser?.uid else {return}
              let toID = id
        ref.collection("messages")
            .document(fromID)
            .collection(toID)
            .addSnapshotListener { (querSnapshot, error) in
                if let err = error {
                    print("Error \(err.localizedDescription)")
                    return
                }else {
                    // Check the documents .doc is an array
                    self.view?.emptyArr()
                    querSnapshot?.documents.forEach({ (queryDocumentSnapShot) in
                        let data    = queryDocumentSnapShot.data()
                        
                        let mssg    = data["mssg"] as? String ?? ""
                        let toID    = data["toId"] as? String ?? ""
                        let fromID = data["fromId"] as? String ?? ""

                        let chatMessage = MessageModel(fromID: fromID, toID: toID, messageContent: mssg)
                        self.view?.messageLoaded(messages: chatMessage)
                    })
                }
            }
    }
    
    //MARK:- Send Message
    
    func sendMessage(txt: String, toID: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let date = Timestamp()
        let values: [String : Any] = [
            "fromId": userID,
            "toId"  : toID,
            "mssg"  : txt,
            "time"  : date
        ]
        let document = ref.collection("messages")
            .document(userID)
            .collection(toID)
            .document()
        document.setData(values) { error in
            if let err = error {
                print("Error while sending the message \(err)")
            }else {
                self.view?.messageSent()
            }
        }
        
        // so the message once will be saved in the other side collections
        let recepientMessageDocument = ref.collection("messages")
            .document(toID)
            .collection(userID)
            .document()
        recepientMessageDocument.setData(values) { error in
            if let err = error {
                print("Error while sending the message \(err)")
            }else {
                self.view?.messageSent()
            }
        }
    }
    
    
    
    
}

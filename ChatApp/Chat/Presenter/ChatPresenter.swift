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
    func userInfo(currUser: UsersModel)
}
//MARK:- Presenter
class ChatPresenter {
    
    //MARK:- Properties
    var view: ChatView?
    let db = Database.database().reference()        // For realtime DB
    let ref = Firestore.firestore()         // For Firestore
    var myInfo = UsersModel()
    //MARK:- Init
    init(view: ChatView) {
        self.view = view
    }
    
    
    //MARK:- Methods
    func currentUserInfo() {
        print("Loading Docs")
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        db.child("users").child(userID).getData { (er, dataSnapShot) in
            if let err = er {
                print("error has been occured while fetching the userdata \(err)")
            }else {
                guard let docs = dataSnapShot?.value as? NSDictionary else {return}
                let username    = docs["username"] as? String
                let email       = docs["email"] as? String
                let id          = docs["userID"]as? String
                let userModel   = UsersModel(email: email, userID: id, username: username)
                self.view?.userInfo(currUser: userModel)
            }
        }
    }
    
    func loadMessages(id: String) {
        
        guard let fromID = Auth.auth().currentUser?.uid else {return}
        let toID = id
        
        ref.collection("messages")
            .document(fromID)
            .collection(toID)
            .order(by: "time")
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
    
    func sendMessage(txt: String, toID: String, toName: String) {
        guard let userID = Auth.auth().currentUser else { return }
        let date = Timestamp()
        let values: [String : Any] = [
            "fromId": userID.uid,
            "toId"  : toID,
            "mssg"  : txt,
            "time"  : date
        ]
        let document = ref.collection("messages")
            .document(userID.uid)
            .collection(toID)
            .document()
        document.setData(values) { error in
            if let err = error {
                print("Error while sending the message \(err)")
            }else {
                self.persistRecentMessagesSender(toId: toID, text: txt, recName: toName)
                self.view?.messageSent()
            }
        }
        
        // so the message once will be saved in the other side collections
        let recepientMessageDocument = ref.collection("messages")
            .document(toID)
            .collection(userID.uid)
            .document()
        recepientMessageDocument.setData(values) { error in
            if let err = error {
                print("Error while sending the message \(err)")
            }else {
                self.persistRecentMessagesReceiver(toId: toID, text: txt, fromName: self.myInfo.username ?? "" )
                self.view?.messageSent()
            }
        }
    }
    
    func persistRecentMessagesSender(toId: String, text: String, recName: String) {
        // Sender
        guard let userID = Auth.auth().currentUser else {return}
        let document = ref.collection("recent_Messages")
            .document(userID.uid)
            .collection("messages")
            .document(toId)
        
        let data :[String: Any] = [
            "timeStamp" : Timestamp(),
            "text"      : text,
            "fromId"    : userID.uid,
            "toId"      : toId,
            "name"    : recName
            // Email & profilePhoto
        ]
        document.setData(data) { (er) in
            if let err = er {
                print("Error RecentMessages \(err) ")
            }else {
                print("Sender: Successfully sent to Firestore")
            }
        }
    }   // End of PersistRecentMessages Func
    
    
    func persistRecentMessagesReceiver(toId: String, text: String, fromName: String) {
        // Sender
        guard let userID = Auth.auth().currentUser else {return}
        let document = ref.collection("recent_Messages")
            .document(toId)
            .collection("messages")
            .document(userID.uid)
        
        let data :[String: Any] = [
            "timeStamp" : Timestamp(),
            "text"      : text,
            "fromId"    : toId,
            "toId"      : userID.uid,
            "name"      : fromName
            
        ]
        document.setData(data) { (er) in
            if let err = er {
                print("Error RecentMessages \(err) ")
            }else {
                print("Receiver Successfully sent to Firestore")
            }
        }
    }   // End of PersistRecentMessages Func
    
    
}

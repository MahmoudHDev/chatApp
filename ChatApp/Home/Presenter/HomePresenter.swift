//
//  HomePresenter.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import Foundation
import Firebase

//MARK:- Protocol

protocol HomeView {
    func emptyTheArray()
    func messagesLoaded(recentMssgs: RecentMessages)
    func userLoaded(users: UsersModel)
    func failedLoaded()
}

//MARK:- Presenter

class HomePresenter {
    //MARK:- Properties
    var view: HomeView?
    let db = Database.database().reference()        // Realtime DataBase
    let ref = Firestore.firestore()                 // Firestore
    
    //MARK:- Init
    init(view: HomeView) {
        self.view = view
    }
    
    //MARK:- Methods
    
    func loadMessages() {
        print("Loading the messages")
        guard let userID = Auth.auth().currentUser else {return}
        let document = ref.collection("recent_Messages")
            .document(userID.uid)
            .collection("messages")
            .order(by: "timeStamp")
        document.addSnapshotListener { (documentSnapshot, er) in
            if let err = er {
                print("error While loading the messages \(err.localizedDescription)")
            }else {
                print("Loading docs")
                self.view?.emptyTheArray()
                documentSnapshot?.documents.forEach({ (queryDocumentSnapshot) in
                    let data = queryDocumentSnapshot.data()
                    // "Message OR USerModel"
                    let text        = data["text"] as? String
                    let to          = data["toId"] as? String
                    let from        = data["fromId"] as? String
                    let name        = data["name"] as? String
                    let RMessages   = RecentMessages(text: text, toId: to, toName: name, fromId: from)
                    self.loadusersName(id: to ?? "")
                    self.view?.messagesLoaded(recentMssgs: RMessages)
                    print(data)
                })
            }
        }
    }
    
    func loadusersName(id: String) {
        db.child("users").child(id).getData { (error, dataSnapshot) in
            print("Loading users")
            if let err = error {
                print("Error While loading the user \(err.localizedDescription)")
            }else {
                guard let data = dataSnapshot?.value as? NSDictionary else {return}
                let email = data["email"] as? String
                let userID = data["userID"] as? String
                let username = data["username"] as? String
                let usersModel = UsersModel(email: email, userID: userID, username: username)
                self.view?.userLoaded(users: usersModel)
                print(data)
            }

        }
    }
    
    
}

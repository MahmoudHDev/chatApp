//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK:- Properties

    @IBOutlet weak var tableView        : UITableView!
    @IBOutlet weak var messageTextfield : UITextField!
    @IBOutlet weak var sendBttn         : UIButton!
    var user        = UsersModel()
    var presenter   : ChatPresenter?
    var arrMessages = [MessageModel]()
    var me          = UsersModel()
    //MARK:- View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = user.username,
              let id       = user.userID else { return }
        
        title = username
        presenter = ChatPresenter(view: self)
        presenter?.currentUserInfo()
        presenter?.loadMessages(id: id)         // the one who i messages
        tableViewConfig()
    }
    
    //MARK:- Actions
    
    @IBAction func send(_ sender: UIButton) {
        if messageTextfield.text != nil {
            guard let textMessage = messageTextfield.text,
                  let toUserID = user.userID else {return}
            presenter?.sendMessage(txt: textMessage, toID: toUserID)
        }
        
    }
}

//MARK:- Presenter
extension ChatViewController: ChatView {
    
    func userInfo(currUser: UsersModel) {
        me = currUser
    }
    
    func emptyArr() {
        arrMessages = []
    }
    
    func messageLoaded(messages: MessageModel) {
        arrMessages.append(messages)
        tableView.reloadData()
        print("Message has been loaded")
    }
    
    func messageSent() {
        print("Message Has been sent")
//        guard let textMsg = messageTextfield.text,
//              let userID  = user.userID,
//              let toName  = user.username,
//              let email   = user.email else {return}
        messageTextfield.text = ""
        
    }
    
}

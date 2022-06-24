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
    var strID       : String?
    var presenter   : ChatPresenter?
    var arrMessages = [MessageModel]()
    var me          = UsersModel()
    
    
    //MARK:- View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ChatPresenter(view: self)
        tableViewConfig()
        if strID == nil {
            guard let username = user.username,
                  let id       = user.userID else { return }
            // what comes after guard doesn't implement unless the guard statment is = true!
            title = username
            presenter?.loadMessages(id: id)         // the one who i messages
        }else{
            presenter?.loadMessages(id: strID!)

        }
        title = "Chat"
        presenter?.currentUserInfo()

        
    }
    
    //MARK:- Actions
    
    @IBAction func send(_ sender: UIButton) {
        if messageTextfield.text != nil {
            guard let textMessage = messageTextfield.text,
                  let toUserID = user.userID,
                  let toName = user.username else {return}
            presenter?.sendMessage(txt: textMessage, toID: toUserID, toName: toName)
        }
    }
}




//MARK:- Presenter
extension ChatViewController: ChatView {
    
    func userInfo(currUser: UsersModel) {
        me = currUser
        presenter?.myInfo = currUser
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
        messageTextfield.text = ""
        
    }
    
}

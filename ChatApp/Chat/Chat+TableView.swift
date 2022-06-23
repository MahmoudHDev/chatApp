//
//  Chat+TableView.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit
import Firebase

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableViewConfig() {
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.delegate      = self
        tableView.dataSource    = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.cornerRadius = 25
        
        if arrMessages.count > 0 {
            guard let userID = Auth.auth().currentUser?.uid else {return cell}
            let msgs = arrMessages[indexPath.row]
            if msgs.fromID == userID {
                cell.bubbleView.image = UIImage(named: "ChatBubble S Low")
                cell.messageCont.text = msgs.messageContent
            }else {
                cell.bubbleView.image = UIImage(named: "ChatBubble R Low")
                cell.messageCont.text = msgs.messageContent
            }

        }else {
            cell.textLabel?.text = "No Messages Yet"
        }
    
        return cell
    }
    
    
    
    
}

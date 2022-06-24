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
        
        if arrMessages.count > 0 {
            guard let userID = Auth.auth().currentUser?.uid else {return cell}
            let msgs = arrMessages[indexPath.row]
            if msgs.fromID == userID {
                cell.bubbleView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                cell.messageCont.text = msgs.messageContent
                
            }else {
                cell.bubbleView.backgroundColor = #colorLiteral(red: 0.4483983517, green: 0.726336658, blue: 0.5608868599, alpha: 1)
                cell.messageCont.text = msgs.messageContent
            }
        }else {
            cell.textLabel?.text = "No Messages Yet"
        }
        DispatchQueue.main.async {
            if self.arrMessages.count > 0 {
                let index = IndexPath(row: self.arrMessages.count - 1, section: 0)
                tableView.scrollToRow(at: index, at: .bottom, animated: true)
            }

        }
        return cell
        
    }
    
    
    
    
}

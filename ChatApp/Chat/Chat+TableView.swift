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
        tableView.separatorStyle = .none
        tableView.delegate      = self
        tableView.dataSource    = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        if arrMessages.count > 0 {
            guard let userID = Auth.auth().currentUser?.uid else {return cell}
            let msgs = arrMessages[indexPath.row]
            if msgs.fromID == userID {
                cell.textLabel?.textColor = .white
                cell.textLabel?.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                cell.textLabel?.text = msgs.messageContent
            }else {
                cell.textLabel?.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                cell.textLabel?.textColor = .white
                cell.textLabel?.text = msgs.messageContent
            }

        }else {
            cell.textLabel?.text = "No Messages Yet"
        }
    
        return cell
    }
    
    
    
    
}

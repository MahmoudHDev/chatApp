//
//  Chat+TableView.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

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
        if arrMessages.count > 0 {
            cell.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = arrMessages[indexPath.row].messageContent
        }else {
            cell.textLabel?.text = "No Messages Yet"
        }
        
        return cell
    }
    
    
}

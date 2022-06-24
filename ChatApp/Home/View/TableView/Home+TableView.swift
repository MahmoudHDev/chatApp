//
//  Home+TableView.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableViewConfig() {
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recentMessages)
        return recentMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if recentMessages.count > 0 {
            let messages = recentMessages[indexPath.row]
            cell.textLabel?.text = messages.toName
            cell.detailTextLabel?.text = messages.text
        }else{
            cell.textLabel?.text = "Sam Louis"
            cell.detailTextLabel?.text = "Hello Sam This is me"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

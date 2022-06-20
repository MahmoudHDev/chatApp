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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Users"
        
        return cell
    }
    
    
}

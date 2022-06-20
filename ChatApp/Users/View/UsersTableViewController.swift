//
//  UsersTableViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class UsersTableViewController: UITableViewController {
    //MARK:- Properties

    var presenter: UsersPresenter?
    var arrUsers = [UsersModel]()
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = UsersPresenter(view: self)
        title = "Contacts"
        tableView.separatorStyle = .none
        presenter?.loadKeys()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrUsers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if arrUsers.count > 0 {
            let user = arrUsers[indexPath.row]
            cell.textLabel?.text = user.username
            cell.detailTextLabel?.text = "Hi this is a message"
        }else {
            cell.textLabel?.text = "No Messages"
        }
        

        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = arrUsers[indexPath.row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "chatViewID") as! ChatViewController
        self.navigationController?.pushViewController(storyBoard, animated: true)
        storyBoard.user = selectedUser
        
        
    }
    
    

}

//MARK:- Presenter
extension UsersTableViewController: UsersView {
    
    func emptyArr() {
//    arrUsers = []
        tableView.reloadData()
    }
    
    func userDidLoad(users: UsersModel) {
        print("Load users \(users)")
        arrUsers.append(users)
        tableView.reloadData()
    }
}

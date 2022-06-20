//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK:- Properties

    @IBOutlet weak var tableView: UITableView!
    var user = UsersModel()
    
    //MARK:- View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = user.username else {return}
        title = username
        tableView.delegate      = self
        tableView.dataSource    = self
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Methods

    

}

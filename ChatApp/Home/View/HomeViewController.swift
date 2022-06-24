//
//  HomeViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newMessage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newMessage.layer.cornerRadius = 0.5 * newMessage.bounds.size.width
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    


}


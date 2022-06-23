//
//  ViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        signinBtn.layer.cornerRadius = 25
        signupBtn.layer.cornerRadius = 25


    }


}


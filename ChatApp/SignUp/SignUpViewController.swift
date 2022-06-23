//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/23/22.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var emailTextfield   : UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signupBttn: UIButton!
    var presenter: SignUpPresenter?
    //MARK:- View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignUpPresenter(view: self)
        signupBttn.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }

    //MARK:- Actions

    @IBAction func signUpBttn(_ sender: Any) {
        
        guard let username = usernameTextfield.text,
              let email = emailTextfield.text,
              let password = passwordTextfield.text else {return}
        presenter?.signUp(email: email, password: password, username: username)
    }
    
}
//MARK:- Presenter
extension SignUpViewController: SignUpView {
    
    func successfullySignedUp() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "homeID")
        self.dismiss(animated: true, completion: nil)
        self.present(storyBoard, animated: true, completion: nil)
    }
    
    func failedSignedUp() {
        print("Failed to sign Up")
    }
    
    
}

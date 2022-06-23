//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK:- Properties

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signinBtn        : UIButton!

    var presenter: LoginPresenter?
    
    //MARK:- View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        presenter = LoginPresenter(view: self)
        // Do any additional setup after loading the view.
    }
    //MARK:- Actions
    @IBAction func signUpBttn(_ sender: UIButton) {
        guard let username = usernameTextfield.text,
              let password = passwordTextfield.text else { return }
        presenter?.signIn(email: username, password: password)
        
    }
    //MARK:- Functions
    func updateUI() {
        signinBtn.layer.cornerRadius = 25
        usernameTextfield.layer.cornerRadius = 25
        passwordTextfield.layer.cornerRadius = 25
    }


}
//MARK:- Presenter

extension LoginViewController: LoginView {
    
    func loginSuccess() {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "homeID")
        self.dismiss(animated: true, completion: nil)
        self.present(storyBoard, animated: true, completion: nil)
    }
    
    func loginFailed() {
        print("Error has been occured")
    }
    
}

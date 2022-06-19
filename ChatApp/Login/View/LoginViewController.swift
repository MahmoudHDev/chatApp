//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var presenter: LoginPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(view: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBttn(_ sender: UIButton) {
        guard let username = usernameTextfield.text,
              let password = passwordTextfield.text else { return }
        presenter?.signIn(email: username, password: password)
        
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

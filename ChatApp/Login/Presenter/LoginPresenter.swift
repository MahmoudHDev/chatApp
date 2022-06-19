//
//  LoginPresenter.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import Foundation
import FirebaseAuth

protocol LoginView {
    func loginSuccess()
    func loginFailed()
}


class LoginPresenter {
    
    //MARK:- Properties
    var view: LoginView?
    
    //MARK:- Init
    init(view: LoginView) {
        self.view = view
    }
    
    //MARK:- Methods
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err {
                print("Login faild \(err)")
                self.view?.loginFailed()
            }else {
                
                print("Login Success")
                self.view?.loginSuccess()
            }
        }
        
        
    }
    

    
}

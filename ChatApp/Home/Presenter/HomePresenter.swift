//
//  HomePresenter.swift
//  ChatApp
//
//  Created by Mahmoud on 6/19/22.
//

import Foundation
import FirebaseFirestore

//MARK:- Protocol

protocol HomeView {
    
    func messagesLoaded()
    func failedLoaded()

}

//MARK:- Presenter

class HomePresenter {
    //MARK:- Properties
    var view: HomeView?
    
    //MARK:- Init
    
    init(view: HomeView) {
        self.view = view
    }
    
    //MARK:- Methods
    // Load Messages

    
}

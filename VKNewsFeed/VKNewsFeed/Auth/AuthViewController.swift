//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/26/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
//        authService = AuthService()
        authService = AppDelegate.shared().authService
        
    }
    
    @IBAction func singInTouch() {
        authService.wakeUpSession()
        
    }
    
  

}

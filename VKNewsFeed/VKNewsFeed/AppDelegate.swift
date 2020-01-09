//
//  AppDelegate.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/26/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegat {
    
    

    var authService = AuthService()
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
//        self.authService = AuthService()
        authService.delegat = self
        let authVC: AuthViewController = AuthViewController.loadFromStoryboard()
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

  
    
//MARK: AuthServiceDelegat
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        print(viewController)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
        let feedVC: NewsFeedViewController = NewsFeedViewController.loadFromStoryboard()
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceDidSighInFail() {
        print(#function)
    }

}


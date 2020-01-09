//
//  AuthService.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/26/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegat: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSighInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7148862"
    private let vkSdk: VKSdk
    
    weak var delegat: AuthServiceDelegat?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline", "wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegat] (state, error) in
            if state == VKAuthorizationState.authorized {
                delegat?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                VKSdk.authorize(scope)
            } else {
                print("Auth problems, state \(state) error \(String(describing: error))")
                delegat?.authServiceDidSighInFail()
            }
        }
    }
    
//    MARK: VKSdkDelegat
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegat?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)

    }
//    MARK: VKSdkUiDelegat
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegat?.authServiceShouldShow(controller)

    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)

    }
    
    
}

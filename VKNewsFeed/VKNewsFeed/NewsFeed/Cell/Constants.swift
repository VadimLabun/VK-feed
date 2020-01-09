//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 10/2/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHieght: CGFloat = 50
    static let postLableInsets = UIEdgeInsets(top: 8 + Constants.topViewHieght + 8, left: 8, bottom: 8, right: 8)
    static let postLableFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    static let bottomViewViewHeight: CGFloat = 44
    static let bottomViewViewWidth: CGFloat = 80
    static let bottonViewViewIconSze: CGFloat = 24
    static let miniFiedPostLimitLines: CGFloat = 8
    static let miniFiedPostLines: CGFloat = 6
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
}

//
//  NewsFeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/30/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postLableFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private var screenWidth: CGFloat = 0.0
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //        MARK: work with postLableFrame
        
        var postLableFrame = CGRect(origin: CGPoint(x: Constants.postLableInsets.left, y: Constants.postLableInsets.top), size: CGSize.zero)
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLableInsets.left - Constants.postLableInsets.right
            var height = text.height(width: width, font: Constants.postLableFont)
            
            let limitHeight = Constants.postLableFont.lineHeight * Constants.miniFiedPostLimitLines
        
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLableFont.lineHeight * Constants.miniFiedPostLines
                showMoreTextButton = true
            }
            
            postLableFrame.size = CGSize(width: width, height: height)
        }
        
        //        MARK: work with moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton == true {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLableFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        
        //        MARK: work with attachmentFrame
        
        let attachmentTop = postLableFrame.size == CGSize.zero ? Constants.postLableInsets.top : moreTextButtonFrame.maxY +  Constants.postLableInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        if let attachment = photoAttachments.first {
            let photoHieght = CGFloat(attachment.height)
            let photoWidth = CGFloat(attachment.width)
            let ratio = CGFloat(photoHieght / photoWidth)
            if photoAttachments.count == 1 {
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                let rowHeight = RowLayout.rowHeightCounter(superViewWidth: cardViewWidth, photoArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
                
        }

        //        MARK: work with bottomViewFrame
        
        let buttonViewTop = max(postLableFrame.maxY, attachmentFrame.maxY)
        let buttonViewFrame = CGRect(origin: CGPoint(x: 0, y: buttonViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //        MARK: work with totalHeight
        
        let totalHeight = buttonViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(bottomViewFrame: buttonViewFrame,
                     totalHeight: totalHeight,
                     postLableFrame: postLableFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame)
    }
        
}

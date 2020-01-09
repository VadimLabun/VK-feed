//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 9/28/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var sheres: String? { get }
    var views:  String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLableFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var iconImageView: WebImageView!
    @IBOutlet var postImageView: WebImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var textLable: UILabel!
    @IBOutlet var likesLable: UILabel!
    @IBOutlet var commentsLable: UILabel!
    @IBOutlet var sheresLable: UILabel!
    @IBOutlet var viewsLable: UILabel!
    @IBOutlet var buttonView: UIView!
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let iconImageView = iconImageView else { return }
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
    }
    
//    func set(viewModel: FeedCellViewModel) {
//        iconImageView.set(imageUrl: viewModel.iconUrlString)
//        nameLable.text = viewModel.name
//        dateLable.text = viewModel.date
//        textLable.text = viewModel.text
//        likesLable.text = viewModel.likes
//        commentsLable.text = viewModel.comments
//        sheresLable.text = viewModel.sheres
//        viewsLable.text = viewModel.views
//    
//        textLable.frame = viewModel.sizes.postLableFrame
//        postImageView.frame = viewModel.sizes.attachmentFrame
//        buttonView.frame = viewModel.sizes.bottomViewFrame
//        
//        if let photoAttachment = viewModel.photoAttachments {
//            postImageView.set(imageUrl: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//    }
}

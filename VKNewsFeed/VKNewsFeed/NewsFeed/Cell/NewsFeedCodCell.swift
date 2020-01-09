//
//  NewsFeedCodCell.swift
//  VKNewsFeed
//
//  Created by Vadim Labun on 10/1/19.
//  Copyright © 2019 Vadim Labun. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedCodCellDelegate: class {
    func revealPost(for cell: NewsFeedCodCell)
}

final class NewsFeedCodCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodCell"
    weak var delegat: NewsFeedCodCellDelegate?
    
//    first layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLableFont
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let galleryCollection = GalleryCollectionView()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let postImageView: WebImageView =  {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()

//    third layer on topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let dateLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    //    third layer on buttonView
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//     fourth layer on bottomView
    
    let likesImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "like")
        return image
    }()
    
    let commentsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "comment")
        return image
    }()
    
    let sharesImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "share")
        return image
    }()
    
    let viewsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "eye")
        return image
    }()
    
    let likesLable: UILabel = {
        let label = UILabel()
        label.text = "457K"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        selectionStyle = .none
        
        iconImageView.layer.cornerRadius = Constants.topViewHieght / 2
        iconImageView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonToutch), for: .touchUpInside)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnButtonView()
        overlayFourthLayerOnButtonView()
    }
    
    @objc func moreTextButtonToutch() {
        delegat?.revealPost(for: self)
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLable.text = viewModel.name
        dateLable.text = viewModel.date
        textLable.text = viewModel.text
        
        likesLable.text = viewModel.likes
        commentsLable.text = viewModel.comments
        sharesLable.text = viewModel.sheres
        viewsLable.text = viewModel.views

        textLable.frame = viewModel.sizes.postLableFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
    
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageUrl:photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollection.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollection.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollection.isHidden = false
            galleryCollection.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollection.isHidden = true
        }
    }
    
    private func overlayFourthLayerOnButtonView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLable)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLable)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLable)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLable)
        
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLable)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLable)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLable)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLable)
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottonViewViewIconSze).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottonViewViewIconSze).isActive = true
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    private func overlayThirdLayerOnButtonView() {
        bottomView.addSubview(likesView)
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        bottomView.addSubview(commentsView)
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        bottomView.addSubview(sharesView)
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        bottomView.addSubview(viewsView)
        viewsView.anchor(top: bottomView.topAnchor,
                        leading: nil,
                        bottom: nil,
                        trailing: bottomView.trailingAnchor,
                        size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
        
        topView.addSubview(nameLable)
        nameLable.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLable.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLable.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: Constants.topViewHieght / 2 - 2).isActive = true
        
        topView.addSubview(dateLable)
        dateLable.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLable.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLable.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLable.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
        
        cardView.addSubview(textLable)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollection)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(bottomView)
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        // MARK: CardView constrains
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

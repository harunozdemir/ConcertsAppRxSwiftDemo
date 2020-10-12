//
//  ItunesContentTableViewCell.swift
//  ITunesSearchApp
//
//  Created by Harun on 12.10.2020.
//  Copyright © 2020 harun. All rights reserved.
//

import UIKit

class ItunesContentTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        return "ItunesContentTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    let PADDING: CGFloat = 4
    let CONTAINER_HEIGHT: CGFloat = 130
    let IMAGE_VIEW_WIDTH: CGFloat = 80
    let IMAGE_VIEW_RATIO: CGFloat = 1/1
    
    var collectionImageView: UIImageView!
    var collectionNameLabel: UILabel!
    var descriptionLabel: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let contentMarginGuide = contentView.layoutMarginsGuide
        
        
        // ContainerView
        let containerView: UIView = .init()
        let containerMarginGuide = containerView.layoutMarginsGuide
        containerView.backgroundColor = .groupTableViewBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: contentMarginGuide.topAnchor, constant: PADDING).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentMarginGuide.bottomAnchor, constant: PADDING).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentMarginGuide.leftAnchor, constant: PADDING).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentMarginGuide.rightAnchor, constant: -PADDING).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: CONTAINER_HEIGHT).isActive = true
        
        // Collection ImageView
        collectionImageView = .init()
        let imageViewMarginGuide = collectionImageView.layoutMarginsGuide
        collectionImageView.backgroundColor = .green
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(collectionImageView)
        
        collectionImageView.leftAnchor.constraint(equalTo: containerMarginGuide.leftAnchor, constant: PADDING).isActive = true
        collectionImageView.centerYAnchor.constraint(equalTo: containerMarginGuide.centerYAnchor).isActive = true
        //collectionImageView.topAnchor.constraint(equalTo: containerMarginGuide.topAnchor, constant: 15).isActive = true
        collectionImageView.widthAnchor.constraint(equalToConstant: IMAGE_VIEW_WIDTH).isActive = true
        collectionImageView.heightAnchor.constraint(equalTo: collectionImageView.widthAnchor, multiplier: IMAGE_VIEW_RATIO).isActive = true
        
        
        //CollectionName Label
        collectionNameLabel = .init()
        let collectionNameLabelMarginGuide = collectionNameLabel.layoutMarginsGuide
        collectionNameLabel.textColor = .black
        collectionNameLabel.font = Style.font(with: .system, weight: .bold, size: .xxxlarge)
        collectionNameLabel.numberOfLines = 0
        collectionNameLabel.sizeToFit()
        collectionNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(collectionNameLabel)
        NSLayoutConstraint(item: collectionNameLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: collectionImageView,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        //collectionNameLabel.bottomAnchor.constraint(equalTo: collectionImageViewMarginGuide.bottomAnchor).isActive = true
        collectionNameLabel.leftAnchor.constraint(equalTo: collectionImageView.rightAnchor, constant: 2*PADDING).isActive = true
        collectionNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -2*PADDING).isActive = true
        
        collectionNameLabel.heightAnchor.constraint(equalToConstant: CONTAINER_HEIGHT/5).isActive = true
        
        
        //Description Label
        descriptionLabel = .init()
        descriptionLabel.textColor = .black
        descriptionLabel.font = Style.font(with: .system, weight: .regular, size: .xlarge)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        //descriptionLabel.topAnchor.constraint(equalTo: collectionNameLabelMarginGuide.bottomAnchor, constant: 2*PADDING).isActive = true
        NSLayoutConstraint(item: descriptionLabel,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: collectionImageView,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: descriptionLabel,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: collectionNameLabel,
                           attribute: .left,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: collectionNameLabelMarginGuide.rightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ItunesContentTableViewCellViewModel, index: Int) {
        
        collectionImageView.setImageFromUrl(ImageURL: viewModel.itunesContent.artworkUrl60)
        
        collectionNameLabel.text = viewModel.itunesContent.collectionName ?? ""
        descriptionLabel.text = viewModel.itunesContent.shortDescription ?? ""
    }
    
    
}

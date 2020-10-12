//
//  ItunesContentDetailViewController.swift
//  ITunesSearchApp
//
//  Created by Harun on 12.10.2020.
//  Copyright © 2020 harun. All rights reserved.
//

import UIKit

class ItunesContentDetailViewController: BaseViewController {
    
    var viewModel: ItunesContentDetailViewModel!
    
    let IMAGE_VIEW_WIDTH: CGFloat = 150
    let IMAGE_VIEW_RATIO: CGFloat = 1/1
    let PADDING: CGFloat = 4
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        title = viewModel.selectedItunesContent?.collectionName ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        //imageView
        let imageView: UIImageView = .init()
        let imageViewMarginGuide = imageView.layoutMarginsGuide
        imageView.setImageFromUrl(ImageURL: viewModel.selectedItunesContent?.artworkUrl100 ?? "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: IMAGE_VIEW_WIDTH).isActive = true
        NSLayoutConstraint(item: imageView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: imageView,
                           attribute: .width,
                           multiplier: IMAGE_VIEW_RATIO,
                           constant: 0.0).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor).isActive = true
        NSLayoutConstraint(item: imageView,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .centerY,
                           multiplier: 0.6,
                           constant: 0.0).isActive = true
        
        
        
        //Title
        let titleLabel: UILabel = .init()
        let titleLabelMarginGuide = titleLabel.layoutMarginsGuide
        titleLabel.text = viewModel.selectedItunesContent?.collectionName ?? ""
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = Style.font(with: .system, weight: .bold, size: .xxxlarge)
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint(item: titleLabel,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: imageView,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageViewMarginGuide.bottomAnchor, constant: 5*PADDING).isActive = true
        
        titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.leftAnchor, constant: 2*PADDING).isActive = true
        titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.rightAnchor, constant: -2*PADDING).isActive = true
        
        
        //Description
        let descriptionLabel: UILabel = .init()
        descriptionLabel.text = viewModel.selectedItunesContent?.longDescription ?? ""
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        descriptionLabel.font = Style.font(with: .system, weight: .regular, size: .xlarge)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(descriptionLabel)
        NSLayoutConstraint(item: descriptionLabel,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: titleLabel,
                           attribute: .left,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: descriptionLabel,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: titleLabel,
                           attribute: .right,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5*PADDING).isActive = true
    
        
    }
    
    
    
}

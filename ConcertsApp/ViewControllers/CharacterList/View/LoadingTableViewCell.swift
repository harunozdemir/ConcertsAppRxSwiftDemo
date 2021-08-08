//
//  LoadingTableViewCell.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    // MARK: - IBOutlets:
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties:
    static let reuseIdentifier: String = "LoadingTableViewCell"
}

//
//  LoadingTableViewCell.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LoadingTableViewCell"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! 
    
}

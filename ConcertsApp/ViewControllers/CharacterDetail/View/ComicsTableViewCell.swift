//
//  ComicsTableViewCell.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit
import Kingfisher

class ComicsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "ComicsTableViewCell"
    
    @IBOutlet private weak var labelComicName: UILabel! {
        didSet {
            labelComicName.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            labelComicName.textColor = .black
            labelComicName.textAlignment = .left
            labelComicName.numberOfLines = 0
            labelComicName.lineBreakMode = .byWordWrapping
        }
    }
 
    var comicsTableViewCellVM: ComicsTableViewCellVM? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        labelComicName.text = comicsTableViewCellVM?.comicName ?? ""
    }
}
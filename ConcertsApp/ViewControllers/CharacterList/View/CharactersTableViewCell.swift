//
//  CharactersTableViewCell.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit
import Kingfisher

class CharactersTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "CharactersTableViewCell"
    
    @IBOutlet private weak var labelCharacterName: UILabel! {
        didSet {
            labelCharacterName.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            labelCharacterName.textColor = .black
            labelCharacterName.textAlignment = .left
            labelCharacterName.numberOfLines = 0
            labelCharacterName.lineBreakMode = .byWordWrapping
        }
    }
    
    @IBOutlet private weak var imageViewCharacter: UIImageView! {
        didSet {
            imageViewCharacter.contentMode = .scaleAspectFit
        }
    }
    
    var charactersTableViewCellVM: CharactersTableViewCellVM? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        labelCharacterName.text = charactersTableViewCellVM?.name ?? ""
        imageViewCharacter.setImage(urlString: charactersTableViewCellVM?.imageUrl ?? "")
    }
}

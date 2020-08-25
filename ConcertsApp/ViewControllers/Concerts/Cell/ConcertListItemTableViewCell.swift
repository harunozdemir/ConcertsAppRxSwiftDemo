//
//  ConcertListItemTableViewCell.swift
//  ConcertsApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import UIKit

class ConcertListItemTableViewCell: UITableViewCell {
  @IBOutlet weak var eventDateNameLabel: UILabel!
  @IBOutlet weak var dateOfShowLabel: UILabel!
  
  func configure(with viewModel: ConcertListItemTableViewCellViewModel, index: Int) {
    eventDateNameLabel.text = viewModel.concert.eventDateName
    dateOfShowLabel.text = viewModel.concert.dateOfShow
    
    
  }
  
    
}

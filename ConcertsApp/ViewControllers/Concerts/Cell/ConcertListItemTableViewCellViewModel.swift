//
//  ConcertListItemTableViewCellViewModel.swift
//  ConcertsApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

final class ConcertListItemTableViewCellViewModel: BaseViewModel {
  let concert: Concert
  
  init(with concert: Concert) {
    self.concert = concert
  }
}

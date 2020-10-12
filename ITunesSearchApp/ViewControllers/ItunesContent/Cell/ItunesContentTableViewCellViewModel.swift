//
//  ItunesContentTableViewCellViewModel.swift
//  ITunesSearchApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

final class ItunesContentTableViewCellViewModel: BaseViewModel {
  let itunesContent: ItunesContentResult
  
  init(with itunesContent: ItunesContentResult) {
    self.itunesContent = itunesContent
  }
}

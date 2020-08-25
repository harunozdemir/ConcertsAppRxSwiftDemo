//
//  ConcertResponse.swift
//  ConcertsApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

final class ConcertResponse: Codable {
  let concerts: [Concert]
  
  enum CodingKeys: String, CodingKey {
    case concerts = "results"
    
  }
  
  init(concerts: [Concert]) {
    self.concerts = concerts
  }
}

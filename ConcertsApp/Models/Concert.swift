//
//  Concert.swift
//  ConcertsApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

final class Concert: Codable {
  let eventDateName, name, dateOfShow, userGroupName: String
  let eventHallName: String
  let imageSource: String
  
  enum CodingKeys: String, CodingKey {
    case eventDateName, name, dateOfShow, userGroupName
    case eventHallName
    case imageSource
    
  }
  
  init(eventDateName: String, name: String, dateOfShow: String, userGroupName: String, eventHallName: String, imageSource: String) {
    self.eventDateName = eventDateName
    self.name = name
    self.dateOfShow = dateOfShow
    self.userGroupName = userGroupName
    self.eventHallName = eventHallName
    self.imageSource = imageSource
  }
}

//
//  CharactersResponse.swift.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - CharactersResponse
struct CharactersResponse: Codable {
  let data: DataObject
  
  enum CodingKeys: String, CodingKey {
    case data = "data"
  }
  
  init(data: DataObject) {
    self.data = data
  }
}

// MARK: - DataObject
struct DataObject: Codable {
    let characters: [Character]?
    
    enum CodingKeys: String, CodingKey {
      case characters = "results"
    }

    init(characters: [Character]?) {
        self.characters = characters
    }
}

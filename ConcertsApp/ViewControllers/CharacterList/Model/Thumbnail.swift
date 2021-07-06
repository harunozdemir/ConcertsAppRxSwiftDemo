//
//  Thumbnail.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - Thumbnail
class Thumbnail: Codable {
    var path: String = ""
    var thumbnailExtension: String = ""
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.path = try container.decodeIfPresent(String.self, forKey: .path) ?? String()
        self.thumbnailExtension = try container.decodeIfPresent(String.self, forKey: .thumbnailExtension) ?? String()
    }
    
    init() {
        
    }
}

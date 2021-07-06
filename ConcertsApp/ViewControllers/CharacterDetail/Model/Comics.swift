//
//  Comics.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - Comics
class Comics: Codable {
    var id: Int = -1
    var title: String = String()
    var modified: String = String()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? String()
        self.modified = try container.decodeIfPresent(String.self, forKey: .modified) ?? String()
    }
    
    init() {
        
    }
}


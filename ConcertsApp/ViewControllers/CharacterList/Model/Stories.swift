//
//  Stories.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - Stories
class Stories: Codable {
    var available: Int = -1
    var collectionURI: String = ""
    var items: [StoriesItem] = []
    var returned: Int = -1
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decodeIfPresent(Int.self, forKey: .available) ?? -1
        self.collectionURI = try container.decodeIfPresent(String.self, forKey: .collectionURI) ?? String()
        self.items = try container.decodeIfPresent([StoriesItem].self, forKey: .items) ?? []
        self.returned = try container.decodeIfPresent(Int.self, forKey: .returned) ?? -1
    }
    
    init() {
        
    }
}

// MARK: - StoriesItem
class StoriesItem: Codable {
    var resourceURI: String = String()
    var name: String = String()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI) ?? String()
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? String()
    }
    
    init() {
        
    }
}


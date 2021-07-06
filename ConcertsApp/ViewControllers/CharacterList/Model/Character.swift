//
//  Character.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - Character
class Character: Codable {
    var id: Int = -1
    var name: String = String()
    var description: String = String()
    var modified: String = String()
    var thumbnail: Thumbnail = Thumbnail()
    var resourceURI: String = String()
    var stories: Stories = Stories()
    var urls: [URLElement] = []

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? String()
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? String()
        self.modified = try container.decodeIfPresent(String.self, forKey: .modified) ?? String()
        self.thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail) ?? Thumbnail()
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI) ?? String()
        self.urls = try container.decodeIfPresent([URLElement].self, forKey: .urls) ?? []
    }

    init() {
        
    }
}

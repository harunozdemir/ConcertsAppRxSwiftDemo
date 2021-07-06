//
//  URLElement.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - URLElement
class URLElement: Codable {
    var type: URLType = .comiclink
    var url: String = String()
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(URLType.self, forKey: .type) ?? .comiclink
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? String()
    }
    
    init() {
        
    }
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}


//
//  ComicsResponse.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

// MARK: - ComicsResponse
struct ComicsResponse: Codable {
    let data: ComicsData
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(data: ComicsData) {
        self.data = data
    }
}

// MARK: - ComicsData
struct ComicsData: Codable {
    let comics: [Comics]?
    
    enum CodingKeys: String, CodingKey {
        case comics = "results"
    }
    
    init(comics: [Comics]?) {
        self.comics = comics
    }
}

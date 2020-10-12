//
//  ItunesContentResponse.swift
//  ITunesSearchApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

// MARK: - ItunesContentResponse
struct ItunesContentResponse: Codable {
    let resultCount: Int
    let results: [ItunesContentResult]
}

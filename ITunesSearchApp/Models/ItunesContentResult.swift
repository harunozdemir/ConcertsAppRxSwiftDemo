//
//  ItunesContentResult.swift
//  ITunesSearchApp
//
//  Created by Harun on 26.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

// MARK: - ItunesContentResult
struct ItunesContentResult: Codable {
    let wrapperType: String?
    let kind: String?
    let collectionID, trackID: Int?
    let artistName: String
    let collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30: String?
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double
    let trackPrice, trackRentalPrice, collectionHDPrice, trackHDPrice: Double?
    let trackHDRentalPrice: Double?
    let releaseDate: String
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String
    let contentAdvisoryRating: String?
    let shortDescription, longDescription: String?
    let hasITunesExtras: Bool?
    let artistID: Int?
    let artistViewURL: String?
    let isStreamable: Bool?
    let resultDescription, copyright: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionArtistID = "collectionArtistId"
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription, hasITunesExtras
        case artistID = "artistId"
        case artistViewURL = "artistViewUrl"
        case isStreamable
        case resultDescription = "description"
        case copyright
    }
}







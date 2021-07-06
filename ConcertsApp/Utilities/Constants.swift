//
//  Constants.swift
//  ConcertsApp
//
//  Created by Harun on 4.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

let publicKey = "c0897e9657eba799bccc70a8b8ec69f7"
let privateKey = "ebe194f4b04db4a52d1548c411d0b6101f57192e"
let ts = "1"
let hash = (ts + privateKey + publicKey).md5Value
let baseUrl = "https://gateway.marvel.com:443/"

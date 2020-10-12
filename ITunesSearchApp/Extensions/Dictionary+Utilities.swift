//
//  Dictionary+Utilities.swift
//  ITunesSearchApp
//
//  Created by Harun on 27.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation
extension Dictionary {
  var prettyPrintedJSON: String? {
    do {
      let data: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
      
      return String(data: data, encoding: .utf8)
    } catch _ {
      return nil
    }
  }
  
  var queryString: String? {
    return self.reduce("") { "\($0!)\($1.0)=\($1.1)&" }
  }
}

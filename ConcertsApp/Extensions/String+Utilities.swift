//
//  String+Utilities.swift
//  ConcertsApp
//
//  Created by Harun on 27.12.2019.
//  Copyright © 2019 harun. All rights reserved.
//

import Foundation

extension String {
  
  func convertToDictionary() -> [String: AnyObject]? {
    if let data = self.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
      } catch {
      }
    }
    return nil
  }
  
}

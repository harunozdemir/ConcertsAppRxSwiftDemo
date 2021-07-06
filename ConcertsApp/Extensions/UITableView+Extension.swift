//
//  UITableView+Extension.swift
//  ConcertsApp
//
//  Created by Harun on 6.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}

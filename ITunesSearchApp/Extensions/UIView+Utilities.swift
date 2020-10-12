//
//  UIView+Utilities.swift
//  ITunesSearchApp
//
//  Created by Harun on 12.10.2020.
//  Copyright © 2020 harun. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    

    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue?.cgColor }
    }
}

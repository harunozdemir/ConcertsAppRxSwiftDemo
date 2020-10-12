//
//  Style.swift
//  Candela
//
//  Created by Harun on 2.10.2020.
//  Copyright © 2020 Linktera. All rights reserved.
//

import Foundation
import UIKit

enum FontFamily: String {
    case sanFrancisco = "SanFranciscoText"
    case museo = "Museo"
    case arial = "Arial"
    case system = ""
    case montserrat = "Montserrat"
}

enum FontWeight: String {
    case bold = "Bold"
    case semiBold = "SemiBold"
    case medium = "Medium"
    case regular = "Regular"
    
    
    // museo
    case regular100 = "Museo100-Regular"
    case regular300 = "Museo300-Regular"
    case regular500 = "Museo500-Regular"
    case regular700 = "Museo700-Regular"
    case regular900 = "Museo900-Regular"
    
}
enum FontSize: CGFloat {
    case xxsmall = 10
    case xsmall = 12
    case small = 13
    case medium = 14
    case large = 16
    case xlarge = 18
    case xxlarge = 20
    case xxxlarge = 22
    case giant  = 40
}

struct Style {
    static let DEFAULT_SPACE: CGFloat = 8
    
    static func font(with family: FontFamily, weight: FontWeight, size: FontSize) -> UIFont {
        //    for family in UIFont.familyNames.sorted() {
        //           let names = UIFont.fontNames(forFamilyName: family)
        //           print("Family: \(family) Font names: \(names)")
        //    }
        return UIFont(name: "\(family.rawValue)-\(weight.rawValue)", size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue)
    }
    
    struct Color {
        /// Alpha 0.5
        static let blackWithAlpha = UIColor.black.withAlphaComponent(0.5)
        /// Alpha 0.5
        static let greenWithAlpha = UIColor(red: 0.49, green: 0.73, blue: 0.00, alpha: 0.5)
        static let green = UIColor(red: 0.49, green: 0.73, blue: 0.00, alpha: 1)
        static let paleGreen = UIColor(red: 0.93, green: 0.96, blue: 0.86, alpha: 1.0)
        static let avocadoGreen = UIColor(red: 0.50, green: 0.72, blue: 0.13, alpha: 1.0)
        static let blue = UIColor(red: 0.05, green: 0.40, blue: 0.88, alpha: 1)
        static let lightGray = UIColor(red: 0.75, green: 0.75, blue: 0.70, alpha: 1)
        static let iceGray = UIColor(red: 0.66, green: 0.68, blue: 0.69, alpha: 1.0)
        static let gray = UIColor(red: 0.35, green: 0.36, blue: 0.37, alpha: 1)
        static let grayPassive = UIColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 1)
        static let lightGrayPassive = UIColor(red: 0.77, green: 0.78, blue: 0.79, alpha:1)
        static let paleGray = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha:1)
        static let facebookBlue = UIColor(red: 0.31, green: 0.49, blue: 0.75, alpha: 1)
        static let googleRed = UIColor(red: 0.87, green: 0.29, blue: 0.19, alpha: 1)
        static let whiteAlpha = UIColor(red: 1, green: 1, blue: 1, alpha: 0.62)
        
    }
}

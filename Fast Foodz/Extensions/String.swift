//
//  String.swift
//  Fast Foodz
//
//  Created by Jordan on 5/30/21.
//

import Foundation
import UIKit

private enum Constants {
    static let subheaderPrefix = "$$$$ • "
    static let subheaderSuffix = " miles"
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    private static func milesFormatting(miles: Double) -> String {
        return String(format: "%.2f", miles)
    }
    
    static func subheaderString(for restaurant: Restaurant) -> String {
        return Constants.subheaderPrefix + milesFormatting(miles: restaurant.distance.metersToMiles()) + Constants.subheaderSuffix
    }
}

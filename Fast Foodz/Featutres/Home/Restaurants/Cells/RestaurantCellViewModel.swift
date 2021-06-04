//
//  RestaurantCellViewModel.swift
//  Fast Foodz
//
//  Created by Jordan on 5/30/21.
//

import Foundation
import UIKit

enum RestaurantCellViewModelConstants {
    static let nameLabelNumberOfLines = 0
    static let nameLabelFont = UIFont.preferredFont(forTextStyle: .title3)
    static let nameLabelTextColor = UIColor.deepIndigo
    static let subheaderLabelNumberOfLines = 0
    static let subheaderLabelFont = UIFont.preferredFont(forTextStyle: .subheadline)
    static let seperatorViewColor = UIColor.londonSky
    static let arrowColor = UIColor.deepIndigo
    static let backgroundColor = UIColor.powderBlue
    
    static let imageViewLeadingConstant: CGFloat = 20.0
    static let topContentPadding: CGFloat = 16.0
    static let imageDimension: CGFloat = 32
    static let seperatorHorizontalPadding: CGFloat = 12.0
    static let seperatorHeight: CGFloat = 2.0
    static let arrowTrailingAnchor: CGFloat = 20.0
    static let labelLeadingAnchor: CGFloat = 12.0
    static let subheaderTopAnchor: CGFloat = 6.0
    static let nameLabelWidthMultiplier: CGFloat = 0.6
    static let arrowImage = UIImage(named: "chevron")
}

class RestaurantCellViewModel {
    private var restaurant: Restaurant
    private var name: String
    
    var getName: String {
        return name
    }
    
    var image: UIImage {
        if let image = UIImage(named: restaurant.foodType.imageString())?.withRenderingMode(.alwaysTemplate) {
            return image
        } else {
            return UIImage()
        }
    }
    
    func attributedText() -> NSAttributedString {

        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.pickleGreen]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lilacGrey]
        
        let subheader = NSMutableAttributedString(string: String.subheaderString(for: restaurant))
        
        var priceRange: Int
        
        if let range = restaurant.price?.count {
            priceRange = range
        } else {
            priceRange = 0
        }
        
        subheader.addAttributes(firstAttributes, range: NSRange(location: 0, length: priceRange))
        subheader.addAttributes(secondAttributes, range: NSRange(location: priceRange, length: subheader.length - priceRange))
        
        return subheader
    }
            
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.name = restaurant.name
    }
}

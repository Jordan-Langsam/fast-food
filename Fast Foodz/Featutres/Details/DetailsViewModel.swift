//
//  DetailsViewModel.swift
//  Fast Foodz
//
//  Created by Jordan on 6/2/21.
//

import Foundation
import MapKit

private enum Constants {
    static let labelVerticalPadding: CGFloat = 12
    static let labelHorizontalPadding: CGFloat = 16
    static let labelFont: UIFont = UIFont.preferredFont(forTextStyle: .title3)
    static let widthToHeightAspectRatio: CGFloat = (9/16)
    static let labelBackgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.85)
    static let mapPaddingGeneric: CGFloat = 16.0
    static let mapPaddingBottom: CGFloat = 24.0
    static let mapCornerRadius: CGFloat = 12.0
    static let callButtonBottomAnchor: CGFloat = 50.0
    static let callButtonHeight: CGFloat = 48.0
    static let callButtonBackgroundColor = UIColor.competitionPurple
    static let callButtonTextColor = UIColor.white
}

class DetailsViewModel {
    
    private let restaurant: Restaurant
    private let userLocation: CLLocationCoordinate2D
    var imageDidLoad: ((UIImage) -> Void)?
    
    var labelText: String {
        return restaurant.name
    }
    
    var labelBackgroundColor: UIColor {
        return Constants.labelBackgroundColor
    }
    
    var labelFont: UIFont {
        return Constants.labelFont
    }
    
    var labelTextColor: UIColor {
        return .white
    }
    
    var labelVerticalAnchor: CGFloat {
        return Constants.labelVerticalPadding
    }
    
    var labelHorizontalAnchor: CGFloat {
        return Constants.labelHorizontalPadding
    }
    
    var getUserLocation: CLLocationCoordinate2D {
        return userLocation
    }
    
    var getRestaurantLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
    }
    
    var mapPaddingGeneric: CGFloat {
        return Constants.mapPaddingGeneric
    }
    
    var mapPaddingBottom: CGFloat {
        return Constants.mapPaddingBottom
    }
    
    var mapCornerRadius: CGFloat {
        return Constants.mapCornerRadius
    }
    
    var callButtonPadding: CGFloat {
        return Constants.mapPaddingGeneric
    }
    
    var callButtonBottomAnchor: CGFloat {
        return Constants.callButtonBottomAnchor
    }
    
    var callButtonHeight: CGFloat {
        return Constants.callButtonHeight
    }
    
    var callButtonBackgroundColor: UIColor {
        return Constants.callButtonBackgroundColor
    }
    
    var callButtonTextColor: UIColor {
        return Constants.callButtonTextColor
    }
    
    var getRestaurantUrl: String {
        return restaurant.url
    }
    
    init(restaurant: Restaurant, userLocation: CLLocationCoordinate2D) {
        self.restaurant = restaurant
        self.userLocation = userLocation
    }
    
    func loadImage() {
        guard let imageUrl = URL(string: restaurant.image_url) else {
            return
        }
        
        UIImage.load(with: imageUrl, completion: { [weak self] image in
            self?.imageDidLoad?(image)
        })
    }
    
    func labelBackgroundHeight() -> CGFloat {
        let baseHeight: CGFloat = Constants.labelVerticalPadding * 2.0
        let constrainedWidth: CGFloat = UIScreen.main.bounds.width - (Constants.labelHorizontalPadding * 2.0)
        
        return baseHeight + labelText.height(withConstrainedWidth: constrainedWidth, font: Constants.labelFont)
    }
    
    func imageHeight() -> CGFloat {
        return UIScreen.main.bounds.width * Constants.widthToHeightAspectRatio
    }
    
    func callBusiness() {
        if let url = URL(string: "tel://" + restaurant.phone),
           UIApplication.shared.canOpenURL(url) {
              if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            } else {
                print("could not open phone number")
            }
    }
}

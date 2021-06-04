//
//  RestaurantListViewModel.swift
//  Fast Foodz
//
//  Created by Jordan on 5/28/21.
//

import Foundation
import UIKit

class RestaurantListViewModel {
    
    private var restaurants = [Restaurant]()
    
    var rowCount: Int {
        return restaurants.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> RestaurantCellViewModel {
        return RestaurantCellViewModel(restaurant: restaurants[indexPath.row])
    }
    
    func setRestaurants(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    func heightFor(indexPath: IndexPath) -> CGFloat {
        let restaurant = restaurants[indexPath.row]
        let verticalPadding: CGFloat = RestaurantCellViewModelConstants.topContentPadding
        let subheaderTopPadding: CGFloat = RestaurantCellViewModelConstants.subheaderTopAnchor

        let labelWidth: CGFloat = (UIScreen.main.bounds.size.width * RestaurantCellViewModelConstants.nameLabelWidthMultiplier)
        
        let subheader = String.subheaderString(for: restaurant)
        
        var minHeight = (verticalPadding * 2) + subheaderTopPadding
        minHeight += restaurant.name.height(withConstrainedWidth: labelWidth, font: UIFont.preferredFont(forTextStyle: .title3))
        
        minHeight += subheader.height(withConstrainedWidth: labelWidth, font: UIFont.preferredFont(forTextStyle: .subheadline))
        
        return minHeight
    }
    
    func restaurant(for index: IndexPath) -> Restaurant {
        return restaurants[index.row]
    }
}

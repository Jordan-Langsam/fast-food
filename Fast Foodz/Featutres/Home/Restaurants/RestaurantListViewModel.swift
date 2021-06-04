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
    
    func restaurant(for index: IndexPath) -> Restaurant {
        return restaurants[index.row]
    }
}

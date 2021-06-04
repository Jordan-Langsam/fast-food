//
//  DetailsMapViewModel.swift
//  Fast Foodz
//
//  Created by Jordan on 6/2/21.
//

import Foundation
import CoreLocation
import UIKit

class DetailsMapViewModel {
    
    private let userLocation: CLLocationCoordinate2D
    private let restaurantLocation: CLLocationCoordinate2D
    
    var getUserLocation: CLLocationCoordinate2D {
        return userLocation
    }
    
    var getRestaurantLocation: CLLocationCoordinate2D {
        return restaurantLocation
    }
    
    init(userLocation: CLLocationCoordinate2D, restaurantLocation: CLLocationCoordinate2D) {
        self.userLocation = userLocation
        self.restaurantLocation = restaurantLocation
    }
}

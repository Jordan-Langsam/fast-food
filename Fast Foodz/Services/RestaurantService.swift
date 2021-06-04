//
//  RestaurantService.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

protocol RestaurantService {
    func restaurantValues(completion: @escaping (ResponseResult<RestaurantsResponseObject>) -> Void, latitude: Double, longitude: Double)
}

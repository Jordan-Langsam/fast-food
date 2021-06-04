//
//  RestaurantServiceAPI.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

final class RestaurantServiceAPI: RestaurantService {

    private let networkRequester: NetworkRequesting
    
    init(networkRequester: NetworkRequesting) {
        self.networkRequester = networkRequester
    }
    
    func restaurantValues(completion: @escaping (ResponseResult<RestaurantsResponseObject>) -> Void, latitude: Double, longitude: Double) {
        networkRequester.requestValue(for: RestaurantsEndpoint(latitude: latitude, longitude: longitude), completion: completion)
    }
}

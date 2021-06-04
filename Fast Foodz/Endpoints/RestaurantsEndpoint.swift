//
//  RestaurantsEndpoint.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation

struct RestaurantsEndpoint: RestEndpoint {
    private enum Constants {
        static let baseURL = "https://api.yelp.com/v3/businesses/search?category=pizza"
        static let latitudeBase = "&latitude="
        static let longitudeBase = "&longitude="
        static let urlSuffix = "&radius=1000&sort_by=distance&categories=pizza,mexican,chinese,burgers"
        
        enum Headers {
            static let authKey = "Authorization"
            static let authValue = "Bearer \(yelpAPIKey)"
        }
    }

    var path: String
    let method: RestMethod = .GET
    var headers: [String : String]? = [Constants.Headers.authKey : Constants.Headers.authValue]
    
    init(latitude: Double, longitude: Double) {
        self.path = Constants.baseURL + Constants.latitudeBase + String(latitude) + Constants.longitudeBase + String(longitude) + Constants.urlSuffix
    }
}

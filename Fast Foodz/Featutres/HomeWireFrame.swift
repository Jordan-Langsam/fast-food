//
//  HomeWireFrame.swift
//  Fast Foodz
//
//  Created by Jordan on 5/28/21.
//

import Foundation
import UIKit
import CoreLocation

final class HomeWireFrame {
    private let modelProvider = ModelProvider()
    private let httpProvider = HTTPProvider(session: URLSession(configuration: .default))
    private let urlRequester = URLRequestProvider()
    private let networkRequester: NetworkRequester
    
    init() {
        networkRequester = NetworkRequester(modelProviding: modelProvider,
                                                httpProviding: httpProvider,
                                                urlRequestProviding: urlRequester)
    }
    
    func buildHomeViewController() -> UIViewController {
        let view = HomeViewController(service: RestaurantServiceAPI(networkRequester: networkRequester), wireframe: self)
        let nav = UINavigationController(rootViewController: view)
        return nav
    }
    
    func buildRestaurantDetailsViewController(restaurant: Restaurant, userLocation: CLLocationCoordinate2D) -> UIViewController {
        let viewModel = DetailsViewModel(restaurant: restaurant, userLocation: userLocation)
        return DetailsViewController(viewModel: viewModel)
    }
}

//
//  HomeMapViewModel.swift
//  Fast Foodz
//
//  Created by Jordan on 5/28/21.
//

import Foundation
import MapKit

class HomeMapViewModel {
    
    private var restaurants: [Restaurant] = [Restaurant]() {
        didSet {
            configureRestaurants?()
        }
    }
    
    private var latitude: Double?
    
    private var longitude: Double?
    
    var getLatitude: Double? {
        if let latitude = latitude {
            return latitude
        }
        
        return nil
    }
    
    var getLongitude: Double? {
        if let longitude = longitude {
            return longitude
        }
        
        return nil
    }
    
    var configureRestaurants: (() -> Void)?
    
    func cameraBondary() -> MKMapView.CameraBoundary {
        guard let latitude = latitude, let longitude = longitude else {
            return MKMapView.CameraBoundary.init()
        }

        let center = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(
            center: center.coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000)

        return MKMapView.CameraBoundary(coordinateRegion: region) ?? MKMapView.CameraBoundary.init()
    }
    
    func cameraZoomRange() -> MKMapView.CameraZoomRange {
        return MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 10000) ?? MKMapView.CameraZoomRange.init()
    }
    
    func setRestaurants(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    func restaurantPins() -> [MKPointAnnotation] {
        var points: [MKPointAnnotation] = [MKPointAnnotation]()
                                           
        restaurants.forEach {
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: $0.coordinates.latitude, longitude: $0.coordinates.longitude)
            points.append(mapAnnotation)
        }
        
        return points
    }
    
    func restaurantFor(coordinate: CLLocationCoordinate2D) -> Restaurant? {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        if let restautant = restaurants.enumerated().first(where: {$0.element.coordinates.latitude == latitude
                                                        &&
            $0.element.coordinates.longitude == longitude
        }) {
            return restautant.element
        }
        
        return nil
    }
    
    func setLatitude(latitude: Double) {
        self.latitude = latitude
    }
    
    func setLongitude(longitude: Double) {
        self.longitude = longitude
    }
}

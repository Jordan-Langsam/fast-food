//
//  LocationManager.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    private enum Constants {
        static let defaultLatitude: Double = 40.758896
        static let defaultLongitude: Double = -73.985130
    }
    
    static let shared = LocationManager()
        private var locationManager: CLLocationManager = CLLocationManager()
        private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?
        var locationUpdated: (([CLLocation]) -> Void)?
        var defaultUserLocation: CLLocation = CLLocation(latitude: Constants.defaultLatitude, longitude: Constants.defaultLongitude)
}

extension LocationManager: CLLocationManagerDelegate {
    public func requestLocationAuthorization() {
        locationManager.delegate = self
        let currentStatus = CLLocationManager.authorizationStatus()

        guard currentStatus == .notDetermined else { return }

        if #available(iOS 13.4, *) {
            requestLocationAuthorizationCallback = { [weak self] status in
                if status == .authorizedWhenInUse {
                    self?.locationManager.requestAlwaysAuthorization()
                }
            }
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }

    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestLocationAuthorizationCallback?(status)

        if (status == .notDetermined) {
            return
        }

        if (manager.location == nil) {
            locationUpdated?([defaultUserLocation])
        } else {
            guard let latitude = manager.location?.coordinate.latitude, let longitude = manager.location?.coordinate.longitude else {
                return
            }

            self.locationUpdated?([CLLocation(latitude: latitude, longitude: longitude)])
        }
    }
}

//
//  HomeMapView.swift
//  Fast Foodz
//
//  Created by Jordan on 5/29/21.
//

import UIKit
import MapKit

private let annotationViewIdentifier = "annotationViewIdentifier"

class HomeMapView: UIView {

    private let mapView = MKMapView()
    private let viewModel: HomeMapViewModel!
    var didTapRestaurant: ((Restaurant) -> Void)?
    
    init(viewModel: HomeMapViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        mapView.delegate = self
        setupHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHandlers() {
        viewModel.configureRestaurants = { [weak self] in
            DispatchQueue.main.async {
                guard let latitude = self?.viewModel.getLatitude, let longitude = self?.viewModel.getLongitude else {
                    return
                }
                
                self?.configureLocation(latitude: latitude, longitude: longitude)
                self?.configureRestaurants()
            }
        }
    }
    
    private func configureRestaurants() {
        mapView.addAnnotations(viewModel.restaurantPins())
        setNeedsLayout()
    }
    
    private func configureLocation(latitude: Double, longitude: Double) {
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        addSubview(mapView)
        setupMapViewContraints()
        mapView.showsUserLocation = true
        mapView.setCameraBoundary(viewModel.cameraBondary(), animated: true)
        mapView.setCameraZoomRange(viewModel.cameraZoomRange(), animated: true)
    }
    
    private func setupMapViewContraints() {
        mapView.backgroundColor = .red
        mapView.addConstraints{[
            $0.topAnchor.constraint(equalTo: self.topAnchor),
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            $0.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ]}
    }
}

extension HomeMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewIdentifier)
    
    
      if (annotation.isKind(of: MKUserLocation.self)) {
          return nil
      }
        
      if annotationView == nil {
          annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationViewIdentifier)

          annotationView?.canShowCallout = false
          annotationView?.isUserInteractionEnabled = true
      } else {
          annotationView?.annotation = annotation
      }

      annotationView?.image = UIImage(named: "pin")
      return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinate = view.annotation?.coordinate else {
            return
        }
        
        if let restaurant: Restaurant = viewModel.restaurantFor(coordinate: coordinate) {
            didTapRestaurant?(restaurant)
        } else {
            assertionFailure("should not be nil")
        }
    }
}

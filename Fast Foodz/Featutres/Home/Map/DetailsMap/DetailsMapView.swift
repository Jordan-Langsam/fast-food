//
//  DetailsMapView.swift
//  Fast Foodz
//
//  Created by Jordan on 6/2/21.
//

import UIKit
import MapKit

class DetailsMapView: UIView {
    
    private let mapView = MKMapView()
    private let viewModel: DetailsMapViewModel
    
    init(viewModel: DetailsMapViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect.zero)
        mapView.delegate = self
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMap() {
        clipsToBounds = true
        addSubview(mapView)
        
        mapView.addConstraints{[
            $0.leadingAnchor.constraint(equalTo: leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: trailingAnchor),
            $0.topAnchor.constraint(equalTo: topAnchor),
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]}
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: viewModel.getUserLocation, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: viewModel.getRestaurantLocation, addressDictionary: nil))
            request.requestsAlternateRoutes = false
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }

                for route in unwrappedResponse.routes {
                    let insetAmount: CGFloat = 30
                    
                    let alteredMap = mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount))

                    self.mapView.addOverlay(route.polyline)
                    self.mapView.setVisibleMapRect(alteredMap, animated: true)
                }
            }
        
    }
}

extension DetailsMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 4.0
        renderer.strokeColor = UIColor.bluCepheus
        return renderer
    }
}

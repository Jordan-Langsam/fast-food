//
//  DetailsViewController.swift
//  Fast Foodz
//
//  Created by Jordan on 6/2/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let viewModel: DetailsViewModel
    private let imageView = UIImageView()
    private let labelBackgroundView = UIView()
    private let label = UILabel()
    private let mapView: DetailsMapView
    
    private let callButton = UIButton()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        self.mapView = DetailsMapView(viewModel: DetailsMapViewModel(userLocation: viewModel.getUserLocation, restaurantLocation: viewModel.getRestaurantLocation))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBar()
        setupImageView()
        setupLabelBackgroundView()
        setupLabel()
        viewModel.loadImage()
        setupCallButton()
        setupMapView()
        setupHandlers()
    }
    
    private func setupHandlers() {
        viewModel.imageDidLoad = { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor.londonSky
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.title = "Details"
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonWasPressed))
        shareButton.image = UIImage(named: "share")
        
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        view.addSubview(imageView)
        
        imageView.addConstraints{[
            $0.topAnchor.constraint(equalTo: view.topAnchor),
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            $0.heightAnchor.constraint(equalToConstant: viewModel.imageHeight()),
            $0.widthAnchor.constraint(equalTo: view.widthAnchor),
        ]}
    }
    
    private func setupLabelBackgroundView() {
        labelBackgroundView.backgroundColor = viewModel.labelBackgroundColor
        imageView.addSubview(labelBackgroundView)
        
        labelBackgroundView.addConstraints{[
            $0.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            $0.widthAnchor.constraint(equalTo: view.widthAnchor),
            $0.heightAnchor.constraint(equalToConstant: viewModel.labelBackgroundHeight())
        ]}
    }
    
    private func setupLabel() {
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = viewModel.labelText
        label.textColor = viewModel.labelTextColor
        label.font = viewModel.labelFont
        
        labelBackgroundView.addSubview(label)
        
        label.addConstraints{[
            $0.topAnchor.constraint(equalTo: labelBackgroundView.topAnchor, constant: viewModel.labelVerticalAnchor),
            $0.bottomAnchor.constraint(equalTo: labelBackgroundView.bottomAnchor, constant: -viewModel.labelVerticalAnchor),
            $0.leadingAnchor.constraint(equalTo: labelBackgroundView.leadingAnchor, constant: viewModel.labelHorizontalAnchor),
            $0.widthAnchor.constraint(equalTo: labelBackgroundView.widthAnchor, constant: -(viewModel.labelHorizontalAnchor * 2.0)),
        ]}
    }
    
    private func setupMapView() {
        mapView.layer.cornerRadius = viewModel.mapCornerRadius
        view.addSubview(mapView)
        
        mapView.addConstraints{[
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.mapPaddingGeneric),
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.mapPaddingGeneric),
            $0.topAnchor.constraint(equalTo: labelBackgroundView.bottomAnchor, constant: viewModel.mapPaddingGeneric),
            $0.bottomAnchor.constraint(equalTo: callButton.topAnchor, constant: -viewModel.mapPaddingBottom)
        ]}
    }
    
    private func setupCallButton() {
        callButton.addTarget(self, action: #selector(callButtonWasPressed), for: .touchUpInside)
        callButton.setTitle("Call Business", for: .normal)
        callButton.setTitleColor(viewModel.callButtonTextColor, for: .normal)
        callButton.backgroundColor = viewModel.callButtonBackgroundColor
        callButton.layer.cornerRadius = 6.0
        view.addSubview(callButton)
        
        callButton.addConstraints{[
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -viewModel.callButtonBottomAnchor),
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewModel.callButtonPadding),
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewModel.callButtonPadding),
            $0.heightAnchor.constraint(equalToConstant: viewModel.callButtonHeight)
        ]}
        
    }
    
    @objc private func shareButtonWasPressed() {
        guard let restaurantURL: URL = URL(string: viewModel.getRestaurantUrl) else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems : [restaurantURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc private func callButtonWasPressed() {
        viewModel.callBusiness()
    }
}

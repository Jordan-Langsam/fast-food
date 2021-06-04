//
//  HomeViewController.swift
//  Fast Foodz
//

import UIKit
import CoreLocation

private struct Constants {
    static let segmentControlTopPadding: CGFloat = 20.0
    static let segmentControlHorizontalPadding: CGFloat = 50.0
    static let segmentControlHeight: CGFloat = 40.0
    static let segmentControlOption1 = "Map"
    static let segmentControlOption2 = "List"
}

final class HomeViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private let mapViewModel = HomeMapViewModel()
    private let listViewModel = RestaurantListViewModel()
    private let service: RestaurantService
    private var segmentedControlView: SegmentedControlView!
    private let mapView: HomeMapView!
    private let loadingIndicatorView = UIActivityIndicatorView.init(style: .large)
    private var wireFrame: HomeWireFrame
    private var userLocation: CLLocationCoordinate2D?
    
    init(service: RestaurantService, wireframe: HomeWireFrame) {
        self.mapView = HomeMapView(viewModel: self.mapViewModel)
        self.service = service
        self.wireFrame = wireframe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        LocationManager.shared.requestLocationAuthorization()
        setupNavigationBar()
        setupLoadingIndicator()
        setupMapView()
        setupTableView()
        setupSegmentControl()
        setupObservers()
        setupHandlers()
        segmentedControlView.setEnabed(enabled: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        tableView.deselectRow(at: selectedIndexPath, animated: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.mapSelectedOptionDidChange, object: nil)
    }
    
    private func setupLoadingIndicator() {
        loadingIndicatorView.backgroundColor = .white
        loadingIndicatorView.color = .gray
        loadingIndicatorView.center = view.center
        view.addSubview(loadingIndicatorView)
        
        loadingIndicatorView.addConstraints {[
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]}
        
        loadingIndicatorView.startAnimating()
    }
        
    private func setupHandlers() {
        mapView.didTapRestaurant = { [weak self] restaurant in
            self?.pushDetailsViewController(restaurant: restaurant)
        }
        
        LocationManager.shared.locationUpdated = { [weak self] locations in 
            guard let coordinates = locations.last?.coordinate else {
                return
            }
            
            self?.userLocation = coordinates
            
            if let location = self?.userLocation {
                self?.mapViewModel.setLatitude(latitude: location.latitude)
                self?.mapViewModel.setLongitude(longitude: location.longitude)
                self?.loadRestaurants(latitude: location.latitude, longitude: location.longitude)
            } else {
                return
            }
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(segmentedControllDidChange(_:)), name: Notification.Name.mapSelectedOptionDidChange, object: nil)
    }
    
    @objc private func segmentedControllDidChange(_ notification: Notification) {
        updateMapVisibility()
        updateListVisibility()
    }
    
    private func loadRestaurants(latitude: Double, longitude: Double) {
        
            service.restaurantValues(completion: { [weak self] result in
                switch result {
                case .success(let restaurants):
                    let restaurants = restaurants.businesses
                    
                    self?.mapViewModel.setRestaurants(restaurants: restaurants)
                    self?.listViewModel.setRestaurants(restaurants: restaurants)
                    
                    DispatchQueue.main.async {
                        self?.segmentedControlView.setEnabed(enabled: true)
                        self?.loadingIndicatorView.isHidden = true
                        self?.updateMapVisibility()
                        self?.updateListVisibility()
                        self?.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print("oops, \(error.localizedDescription)")
                }
            },
            latitude: latitude,
            longitude: longitude)
    }
    
    private func setupMapView() {
        mapView.isHidden = true
        view.addSubview(mapView)
        
        mapView.addConstraints {[
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]}
    }
    
    private func updateMapVisibility() {
        mapView.isHidden = !SegmentedControlManager.shared.getMapIsSelected()
    }
    
    private func updateListVisibility() {
        tableView.isHidden = SegmentedControlManager.shared.getMapIsSelected()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Fast Food Places"
    }
    
    private func setupTableView() {
        tableView.isHidden = true
        tableView.register(cell: RestaurantCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.addConstraints {[
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]}
        
    }
    
    private func setupSegmentControl() {
        segmentedControlView = SegmentedControlView(option1Title: Constants.segmentControlOption1, option2Title: Constants.segmentControlOption2)
        view.addSubview(segmentedControlView)
        
        segmentedControlView.addConstraints {[
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.segmentControlTopPadding),
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.segmentControlHorizontalPadding),
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.segmentControlHorizontalPadding),
            $0.heightAnchor.constraint(equalToConstant: Constants.segmentControlHeight)
        ]}
        
    }
    
    private func pushDetailsViewController(restaurant: Restaurant) {
        
        guard let userLocation = userLocation else {
            return
        }
        
        let detailsController = wireFrame.buildRestaurantDetailsViewController(restaurant: restaurant, userLocation: userLocation)
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.identifier, for: indexPath) as! RestaurantCell
        cell.configure(with: listViewModel.cellViewModel(for: indexPath))
        
        let rectOfCellInTableView = tableView.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
        
        cell.updateIconColor(yPosition: rectOfCellInSuperview.origin.y, maxHeight: tableView.frame.height)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listViewModel.heightFor(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = listViewModel.restaurant(for: indexPath)
        pushDetailsViewController(restaurant: restaurant)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == tableView else {
            return
        }
                
        tableView.indexPathsForVisibleRows?.forEach {
            guard let cell: RestaurantCell = tableView.cellForRow(at: $0) as? RestaurantCell else {
                return
            }

            let rectOfCellInTableView = tableView.rectForRow(at: $0)
            let rectOfCellInSuperview = tableView.convert(rectOfCellInTableView, to: tableView.superview)
            
            cell.updateIconColor(yPosition: rectOfCellInSuperview.origin.y, maxHeight: tableView.frame.height)
        }
    }
}


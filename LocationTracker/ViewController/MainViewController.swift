//
//  MainViewController.swift
//  LocationTracker
//
//  Created by Consultant on 4/23/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    var locationManager = CLLocationManager()
    var timer = Timer()
    var interval: Double = 2*60 //2 minutes
    var viewModel = LocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        locationManager.delegate = self

        setupLocationService()
        viewModel.loadStoredLocations()
    }
    
    func setupLocationService() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    @objc func decreaseLocationRadius() {
        let currentAccuracy = locationManager.desiredAccuracy
        
        switch currentAccuracy {
            
        case kCLLocationAccuracyBest:
            
            self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            self.locationManager.distanceFilter = 99999
            
        case kCLLocationAccuracyThreeKilometers:
            
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = kCLDistanceFilterNone
            
        default:
            print("Accuracy not Changed")
        }
    }
    
}

extension MainViewController: LocationUpdateDelegate {
    func update() {
        
    }
}

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
    var updatesEnabled: Bool!
    var startTime: DispatchTime!
    var endTime: DispatchTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        locationManager.delegate = self

        setupLocationService()
    }
    
    func setupLocationService() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
        
        updatesEnabled = true
        startTime = DispatchTime.now()
    }
    
    func updateLocationService() {
        
        endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        
        if updatesEnabled {
            updatesEnabled = false
            locationManager.stopUpdatingLocation()
            startTime = DispatchTime.now()
        }
        else {
            if timeInterval >= 120{
                updatesEnabled = true
                locationManager.startUpdatingLocation()
            }
        }
    }
}


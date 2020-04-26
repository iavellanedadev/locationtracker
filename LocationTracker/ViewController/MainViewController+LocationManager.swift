//
//  MainViewController+LocationManager.swift
//  LocationTracker
//
//  Created by Consultant on 4/24/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("always track location")
        }
        else if status == .authorizedWhenInUse {
            print("location track Only when in use")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let accuracy = locationManager.desiredAccuracy
            
            if accuracy != kCLLocationAccuracyThreeKilometers {
                viewModel.saveLocation(coordinates: location)
                timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(decreaseLocationRadius), userInfo: nil, repeats: false)
                decreaseLocationRadius()
            }
        }
    }
}

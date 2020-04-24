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

        print("didUpdateLocations Called")
            if let location = locations.last {
                print("New Location is \(location)")
                updateLocationService()
            }
    }
}

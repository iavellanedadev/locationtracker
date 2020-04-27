//
//  GeoCoder.swift
//  LocationTracker
//
//  Created by Consultant on 4/25/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation
import CoreLocation

typealias GeoCodeCompletionHandler = (_ results: Result<CLPlacemark, Error>) -> Void

protocol GetLocationInfo: AnyObject {
    var geoCoder: CLGeocoder { get set }
    
    func getInfoFromLocation(location: CLLocation, completion: @escaping GeoCodeCompletionHandler)
}

class GeoCoder: GetLocationInfo {
    
    var geoCoder: CLGeocoder = CLGeocoder()
    
    func getInfoFromLocation(location: CLLocation, completion: @escaping GeoCodeCompletionHandler) {
        print("reverse geocoder")

        geoCoder.reverseGeocodeLocation(location){ placemarks, error in
            if let error = error {
                print("Error with Reverse Geocode: \(error.localizedDescription)")
                completion(.failure(error))
            }
            
            if let safePlaceMarks = placemarks, let placemark = safePlaceMarks.first {
                completion(.success(placemark))
            }
            
        }
    
    }
}

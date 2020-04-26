//
//  LocationViewModel.swift
//  LocationTracker
//
//  Created by Consultant on 4/24/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationUpdateDelegate: AnyObject {
    func update()
}

class LocationViewModel {
    weak var delegate: LocationUpdateDelegate?
    
    
    var locations = [Location](){
        didSet {
            delegate?.update()
        }
    }
    var location: Location?
}

extension LocationViewModel{
    private func formatLocation(location: CLLocation, address: String, city: String, state: String, country: String, zip: String) -> Location {
        let time = location.timestamp
        let coordinates = location.coordinate
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.string(from: Date())
        let startTime = timeFormatter.string(from: time)
        
        return Location(startTime: startTime, latitude: String(latitude), longitude: String(longitude), date: date)
    }
    
    private func reverseGeocode(location: CLLocation) {
        GeoCoder().getInfoFromLocation(location: location) { [weak self] result in
            switch result {
            case .success(let placemark):
                self?.location = self?.formatLocation(location: location, address: placemark.thoroughfare ?? "N/A", city: placemark.locality ?? "N/A", state: placemark.administrativeArea ?? "N/A", country: placemark.country ?? "N/A", zip: placemark.postalCode ?? "N/A")
            case .failure(let error):
                print("Error Encountered: \(error.localizedDescription)")
            }
           
        }
    }
}

extension LocationViewModel {
    public func saveLocation(coordinates: CLLocation) {
        print("location saved")
        reverseGeocode(location: coordinates)
        
        guard let location = location else { return }
        
        CoreManager.shared.saveData(location)
        loadStoredLocations()
    }
    
    public func loadStoredLocations() {
        locations = CoreManager.shared.loadData()
    }
}

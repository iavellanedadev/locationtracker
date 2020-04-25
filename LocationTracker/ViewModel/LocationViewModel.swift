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
}

extension LocationViewModel{
    private func formatLocation(location: CLLocation) -> Location{
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
}

extension LocationViewModel {
    public func saveLocation(location: CLLocation) {
        
        print("location save")
        let locationTrack = formatLocation(location: location)
        
        CoreManager.shared.saveData(locationTrack)
        loadStoredLocations()
    }
    
    public func loadStoredLocations()
    {
        locations = CoreManager.shared.loadData()
    }
}

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
    var location: Location? {
        didSet {
            guard let location = location,
            let lat = Double(location.latitude),
            let long = Double(location.longitude) else { return }
            coordinates = CLLocation(latitude: lat, longitude: long)
        }
    }
    
    var coordinates: CLLocation?
    
    var lastLocation: Location?
}

extension LocationViewModel{
    private func formatLocation(location: CLLocation, address: String, city: String, state: String, country: String, zip: String) {
        let time = location.timestamp
        let coordinates = location.coordinate
        let latitude = coordinates.latitude
        let longitude = coordinates.longitude
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = dateFormatter.string(from: time)
        print("formatted location")
        self.location = Location(fromDateTime: date, latitude: String(latitude), longitude: String(longitude), address: address, locationName: "\(city), \(state) \(zip) (\(country))", toDateTime: nil, timeSpent: nil)
        
        insertLocation()
    }
    
    private func reverseGeocode(location: CLLocation) {
        GeoCoder().getInfoFromLocation(location: location) { [weak self] result in
            switch result {
            case .success(let placemark):
                self?.formatLocation(location: location, address: placemark.thoroughfare ?? "N/A", city: placemark.locality ?? "N/A", state: placemark.administrativeArea ?? "N/A", country: placemark.country ?? "N/A", zip: placemark.postalCode ?? "N/A")
            case .failure(let error):
                print("Error Encountered: \(error.localizedDescription)")
            }
        }
    }
    
    private func getDistance(from location: CLLocation, to location2: CLLocation) -> Double{
        return location.distance(from: location2)
    }
}

extension LocationViewModel {
    public func saveLocation(coordinates: CLLocation) {
        print("location saved")
        let lastLocation = CoreManager.shared.loadLastRecord()
        reverseGeocode(location: coordinates)
        print("finished reverse geocode")
        
    }
    
    private func insertLocation() {
        guard let location = location else { return }
        
        print("did we hit?")
        if let lastLoc = lastLocation, let lastLat = Double(lastLoc.latitude), let lastLong = Double(lastLoc.longitude), let coordinates = coordinates {
            
            let lastCoordinates = CLLocation(latitude: lastLat, longitude: lastLong)
            
            if getDistance(from: coordinates, to: lastCoordinates) > 100 {
                //update location with toDateTime and timeSpent
                print("further than 100")
                CoreManager.shared.updateData()
            }
        }
        
        
        CoreManager.shared.saveData(location)// save new location
        
        loadStoredLocations()
    }
    
//    public func sendPayload() {
//        guard let location = location, let someUrl = URL(string: "https://blahblahblah.com/testendpoint") else { return }
//        var payload = Payload(appId: "1024-4", time: Date(), locationData: location)
//        APIManager().postData(payload, to: someUrl, completion: { [weak self] result in
//            switch result {
//            case .success(let responseMsg):
//                print("Response Message Recieved")
//            case .failure(let error):
//                print("Error Posting Payload: \(error.localizedDescription)")
//            }
//
//        })
//    }
    
    public func loadStoredLocations() {
        locations = CoreManager.shared.loadData()
    }
}

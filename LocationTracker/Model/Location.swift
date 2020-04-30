//
//  Location.swift
//  LocationTracker
//
//  Created by Consultant on 4/24/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

struct Location : Codable {
    var fromDateTime: String
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var address: String
    var toDateTime: String
    var timeSpent: Double = 0.0
    
    init(fromDateTime: String, latitude: Double, longitude: Double, address: String, toDateTime: String, timeSpent: Double) {
        self.fromDateTime = fromDateTime
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.toDateTime = toDateTime
        self.timeSpent = timeSpent
    }
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "positionx"
        case longitude = "positiony"
        case fromDateTime = "fromTime"
        case address = "Address"
        case toDateTime = "toTime"
        case timeSpent
    }
    
}

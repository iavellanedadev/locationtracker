//
//  Location.swift
//  LocationTracker
//
//  Created by Consultant on 4/24/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

struct Location : Codable {
    let fromDateTime: String
    let latitude: String
    let longitude: String
    let address: String
    let toDateTime: String?
    let timeSpent: Double?
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "positionx"
        case longitude = "positiony"
        case fromDateTime = "fromTime"
        case address = "Address"
        case toDateTime = "toTime"
        case timeSpent
    }
    
}

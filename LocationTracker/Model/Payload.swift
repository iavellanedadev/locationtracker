//
//  Payload.swift
//  LocationTracker
//
//  Created by Consultant on 4/29/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

struct Payload : Codable {
    let appId: String
    let time: Date
    let locationData: Location
    
    private enum CodingKeys : String, CodingKey {
        case appId
        case time
        case locationData = "empData"
    }
}

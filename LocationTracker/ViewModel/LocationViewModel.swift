//
//  LocationViewModel.swift
//  LocationTracker
//
//  Created by Consultant on 4/24/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

protocol LocationUpdateDelegedate: AnyObject {
    func update()
}

class LocationViewModel {
    weak var delegate: LocationUpdateDelegedate?
    
}

extension LocationViewModel {
    public func saveLocation() {
        
    }
}

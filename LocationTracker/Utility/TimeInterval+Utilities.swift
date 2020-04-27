//
//  TimeInterval+Utilities.swift
//  LocationTracker
//
//  Created by Consultant on 4/26/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

extension TimeInterval {
    func toString() -> String {
        let time = Int(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
}

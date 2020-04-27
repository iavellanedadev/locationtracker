//
//  Date+Utility.swift
//  LocationTracker
//
//  Created by Consultant on 4/26/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}

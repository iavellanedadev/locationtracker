//
//  String+Utility.swift
//  LocationTracker
//
//  Created by Consultant on 4/26/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}

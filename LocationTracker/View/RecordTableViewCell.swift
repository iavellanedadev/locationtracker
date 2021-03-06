//
//  RecordTableViewCell.swift
//  LocationTracker
//
//  Created by Consultant on 4/23/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    
    static let identifier = "RecordTableViewCell"
    
    public func setupCellWithData(fromDateTime: String, latitude: String, longitude: String) {
        dateLabel.text = fromDateTime
        latLongLabel.text = "\(latitude), \(longitude)"
//        timeLabel.text = ""
    }

}

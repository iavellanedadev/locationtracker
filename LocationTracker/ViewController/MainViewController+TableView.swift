//
//  MainViewController+TableView.swift
//  LocationTracker
//
//  Created by Consultant on 4/23/20.
//  Copyright © 2020 Avellaneda. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier) as? RecordTableViewCell else { return UITableViewCell() }
        
        let location = viewModel.locations[indexPath.row]
        cell.setupCellWithData(date: location.date, startTime: location.startTime, latitude: location.latitude, longitude: location.longitude)
        
        return cell
    }

}

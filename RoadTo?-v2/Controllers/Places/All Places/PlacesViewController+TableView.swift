//
//  File.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import Foundation
import UIKit

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        self.placesTableView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

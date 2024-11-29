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
        return DataManager.shared.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath) as! PlacesTableViewCell
          let place = DataManager.shared.places[indexPath.row]
          
          cell.configure(with: place)
          
          return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = DataManager.shared.places[indexPath.row]  // DataManager'dan alınan veri
        let detailVC = PlaceDetailsViewController()
        detailVC.place = selectedPlace // Seçilen yeri yeni ekrana gönder
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    
    
}

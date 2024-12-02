//
//  File.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import Foundation
import UIKit

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func setupTableView() {
        placesTableView.delegate = self
        placesTableView.dataSource = self
        searchBar.delegate = self
        self.placesTableView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredPlaces.count  // Filtrelenmiş yerlerin sayısını döndür
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath) as! PlacesTableViewCell
            let place = filteredPlaces[indexPath.row]
            cell.configure(with: place)
            return cell
        }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = DataManager.shared.places[indexPath.row]  // DataManager'dan alınan veri
        let detailVC = PlaceDetailsViewController()
        detailVC.place = selectedPlace // Seçilen yeri yeni ekrana gönder
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                // Eğer arama kutusu boşsa, tüm yerleri göster
                filteredPlaces = allPlaces
            } else {
                // Arama metnine göre yerleri filtrele
                filteredPlaces = allPlaces.filter { place in
                    place.placeName.lowercased().contains(searchText.lowercased())
                }
            }
            
            // Tabloyu güncelle
            placesTableView.reloadData()
        }

    
    
}

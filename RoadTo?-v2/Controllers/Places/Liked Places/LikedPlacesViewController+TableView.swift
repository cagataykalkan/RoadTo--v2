//
//  Untitled.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 28.11.2024.
//

import UIKit

extension LikedPlacesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView() {
        likedPlacesTableView.delegate = self
        likedPlacesTableView.dataSource = self
        
        // XIB dosyasını kaydet
        likedPlacesTableView.register(UINib(nibName: "PlacesTableViewCell", bundle: nil), forCellReuseIdentifier: "PlacesCell")
        
        likedPlacesTableView.backgroundColor = .clear
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath) as! PlacesTableViewCell
        let placeData = likedPlaces[indexPath.row]
        cell.configure(with: placeData)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // likedPlaces dizisinden seçilen yeri al
        let selectedPlace = likedPlaces[indexPath.row]  // likedPlaces dizisinden alınan veri
        let detailVC = PlaceDetailsViewController()
        detailVC.place = selectedPlace  // Seçilen yeri yeni ekrana gönder
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

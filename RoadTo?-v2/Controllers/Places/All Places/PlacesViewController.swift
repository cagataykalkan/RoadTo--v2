//
//  AllPlacesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import UIKit
import FirebaseFirestore
import CoreLocation

class PlacesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var placesTableView: UITableView!
    
    var allPlaces: [PlaceData] = []  // Tüm yerler
    var filteredPlaces: [PlaceData] = []  // Filtrelenmiş yerler
    var userLocation: CLLocation?  // Kullanıcı konumu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        
        
        DataManager.shared.fetchPlacesFromFirestore { [weak self] success in
            if success {
                self?.allPlaces = DataManager.shared.places
                self?.filteredPlaces = self?.allPlaces ?? []
                
                if let location = self?.userLocation {
                    self?.sortPlacesByProximity(to: location)
                }
                
                DispatchQueue.main.async {
                    self?.placesTableView.reloadData()
                }
            } else {
                print("Veri çekme başarısız.")
            }
        }
    }

    func sortPlacesByProximity(to location: CLLocation) {
            let sortedPlaces = allPlaces.sorted { place1, place2 in
                guard
                    let latitude1 = Double(place1.Xcoordinate),
                    let longitude1 = Double(place1.Ycoordinate),
                    let latitude2 = Double(place2.Xcoordinate),
                    let longitude2 = Double(place2.Ycoordinate)
                else {
                    return false
                }

                let location1 = CLLocation(latitude: latitude1, longitude: longitude1)
                let location2 = CLLocation(latitude: latitude2, longitude: longitude2)

                let distance1 = location.distance(from: location1)
                let distance2 = location.distance(from: location2)

                return distance1 < distance2
            }

            allPlaces = sortedPlaces
            filteredPlaces = allPlaces
        }

    
    func setupUI() {
        
        placesTableView.register(UINib(nibName: "PlacesTableViewCell", bundle: nil), forCellReuseIdentifier: "PlacesCell")
        setupTableView()
        
        placesTableView.rowHeight = 250 // Hücre yüksekliği (örneğin, 100 piksel)
        
        let titleLabel = UILabel()
        titleLabel.text = "RoadTo? Denizli"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.purple)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), style: .plain, target: self, action: #selector(navBarButtonTapped))
    }
    
    @objc private func navBarButtonTapped() {
        let vc = LikedPlacesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

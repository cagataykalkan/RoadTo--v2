//
//  AllPlacesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import UIKit
import FirebaseFirestore

class PlacesViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var placesTableView: UITableView!
    
    var allPlaces: [PlaceData] = []  // Tüm yerler
    var filteredPlaces: [PlaceData] = []  // Filtrelenmiş yerler
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        
        // Veriyi bir kere çek
        DataManager.shared.fetchPlacesFromFirestore { [weak self] success in
                    if success {
                        // Veriyi sakla ve filtreleme yap
                        self?.allPlaces = DataManager.shared.places // Tüm yerler alındı
                        self?.filteredPlaces = self?.allPlaces ?? []  // Başlangıçta tüm yerleri göster
                        DispatchQueue.main.async {
                            self?.placesTableView.reloadData()
                        }
                    } else {
                        print("Veri çekme başarısız.")
                    }
                }

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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(navBarButtonTapped))
    }
    
    @objc private func navBarButtonTapped() {
        let vc = LikedPlacesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

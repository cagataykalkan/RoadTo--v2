//
//  LikedPlacesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 28.11.2024.
//

import UIKit

class LikedPlacesViewController: UIViewController {
    
    @IBOutlet weak var likedPlacesTableView: UITableView!
    
    @IBOutlet weak var startButton: UIButton!
    
    var likedPlaces: [PlaceData] {
        return DataManager.shared.places.filter { $0.isLiked }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    func setupUI() {
        
        likedPlacesTableView.register(UINib(nibName: "PlacesTableViewCell", bundle: nil), forCellReuseIdentifier: "PlacesCell")
        setupTableView()
        
        likedPlacesTableView.rowHeight = 250 // Hücre yüksekliği (örneğin, 100 piksel)
        
        let titleLabel = UILabel()
        titleLabel.text = "Denizli Beğenilenleri"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.yellow)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        startButton.backgroundColor = UIColor(named: K.BrandColors.yellow)
        startButton.addCornerRadius(25)
        startButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsSemiBold, size: 20)
        startButton.tintColor = UIColor(named: K.BrandColors.purple)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isViewLoaded {
            reloadPlaces()
        }
    }
    
    func reloadPlaces() {
        let currentLikedPlaces = DataManager.shared.places.filter { $0.isLiked }
        
        if currentLikedPlaces.isEmpty {
            if !(self.navigationController?.topViewController is EmptyLikedPlacesViewController) {
                let emptyVC = EmptyLikedPlacesViewController()
                
                UIView.transition(with: self.view,
                                duration: 0.3,
                                options: .transitionCrossDissolve,
                                animations: {
                    self.navigationController?.pushViewController(emptyVC, animated: false)
                }, completion: nil)
            }
        } else {
            if self.navigationController?.topViewController is EmptyLikedPlacesViewController {
                self.navigationController?.popViewController(animated: true)
            }
            likedPlacesTableView.reloadData()
        }
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let vc = RoutesViewController(likedPlaces: likedPlaces)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

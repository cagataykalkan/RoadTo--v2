//
//  EmptyLikedPlacesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 28.11.2024.
//

import UIKit

class EmptyLikedPlacesViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }


    func setupUI() {
        messageLabel.text = "Başlamak için yerleri seçin😎"
        messageLabel.font = UIFont(name: K.Fonts.poppinsBold, size: 38)
        
        let titleLabel = UILabel()
        titleLabel.text = "RoadTo?"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        navigationItem.hidesBackButton = true
        
        backButton.backgroundColor = UIColor(named: K.BrandColors.purple)
        backButton.tintColor = UIColor(named: K.BrandColors.lightPurple)
        backButton.addCornerRadius(25)
        backButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsBold, size: 24)
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        let vc = PlacesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

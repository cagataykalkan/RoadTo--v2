//
//  LikedPlacesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import UIKit

class PlaceDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var likeButton: UIButton!
    let likeButtonImages = ["unlikedIcon","likedIcon"]
    var likeButtonImagesIndex = 0
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var placeLocationLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeStarLabel: UILabel!
    @IBOutlet weak var shadowImage: UIImageView!
    //image
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var valueOfTimeToSpend: UILabel!
    @IBOutlet weak var suitabilityForBabyCheck: UILabel!
    @IBOutlet weak var suitabilityForFamilyCheck: UILabel!
    @IBOutlet weak var timeToSpend: UILabel!
    @IBOutlet weak var suitabilityForBaby: UILabel!
    @IBOutlet weak var suitabilityForFamily: UILabel!
    
    @IBOutlet weak var placeExplanationLabel: UILabel!
    
    
    var place: PlaceData? // Tıklanan yerin bilgilerini tutacak
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        
        setupData()
        
        setupUI()
    }

    private func setupScrollView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // ScrollView ve ContentView bağlantıları
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        // ContentView'un minimum yüksekliği
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor).isActive = true

        // placeExplanationLabel bağlantıları
        NSLayoutConstraint.activate([
            placeExplanationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            placeExplanationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            placeExplanationLabel.topAnchor.constraint(equalTo: suitabilityForFamilyCheck.bottomAnchor, constant: 16),
            placeExplanationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    
    
    private func setupData() {
        guard let currentPlace = place else { return }
        
        // Mekan bilgilerini ekrana yerleştir
        placeImage.image = UIImage(named: currentPlace.placeImageName)
        placeNameLabel.text = currentPlace.placeName
        placeStarLabel.text = String(currentPlace.placeStar)
        placeLocationLabel.text = currentPlace.placeLocationName
        valueOfTimeToSpend.text = "\(currentPlace.timeToSpend) Dakika"
        
        // Çocuk için uygunluk
        suitabilityForBabyCheck.text = currentPlace.isSuitableForChild ? "✅" : "❌"
        
        // Aile için uygunluk
        suitabilityForFamilyCheck.text = currentPlace.isSuitableForFamily ? "✅" : "❌"
        
        // Butonun görselini ayarla (isLiked durumuna göre)
        likeButtonImagesIndex = currentPlace.isLiked ? 1 : 0
        likeButton.setImage(UIImage(named: likeButtonImages[likeButtonImagesIndex]), for: .normal)
        
        placeExplanationLabel.text = currentPlace.placeExplanation
    }

    private func setupUI() {
        
        backButton.addCornerRadius(20)
        backButton.alpha = 0.85
        
        likeButton.addCornerRadius(20)
        likeButton.alpha = 0.85
        
        shadowImage.alpha = 0.6
        shadowImage.addCornerRadius(20)
        
        placeImage.addCornerRadius(20)
        placeNameLabel.textColor = UIColor(named: K.BrandColors.white)
        placeNameLabel.font = UIFont(name: K.Fonts.poppinsSemiBold, size: 24)
        
        placeLocationLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 18)
        placeLocationLabel.textColor = UIColor(named: K.BrandColors.grey3)
        
        placeStarLabel.textColor = UIColor(named: K.BrandColors.grey3)
        placeStarLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 18)
        
        suitabilityForFamily.addCornerRadius(12.5)
        suitabilityForFamily.layer.masksToBounds = true
        
        suitabilityForBaby.addCornerRadius(12.5)
        suitabilityForBaby.layer.masksToBounds = true
        
        timeToSpend.addCornerRadius(12.5)
        timeToSpend.layer.masksToBounds = true
        valueOfTimeToSpend.font = UIFont(name: K.Fonts.poppinsRegular, size: 14)
        valueOfTimeToSpend.textColor = UIColor(named: K.BrandColors.grey)
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        guard var currentPlace = place else { return }
            
            // `isLiked` durumunu değiştir
            currentPlace.isLiked.toggle()
            place?.isLiked = currentPlace.isLiked
            
            // DataManager'deki ilgili yeri güncelle
            if let index = DataManager.shared.places.firstIndex(where: { $0.placeName == currentPlace.placeName }) {
                DataManager.shared.places[index].isLiked = currentPlace.isLiked
            }
            
            // Buton görselini güncelle
            likeButtonImagesIndex = currentPlace.isLiked ? 1 : 0
            likeButton.setImage(UIImage(named: likeButtonImages[likeButtonImagesIndex]), for: .normal)
        
        print(currentPlace.isLiked)
    }
    
    
}

//
//  LikedPlacesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import UIKit

class PlaceDetailsViewController: UIViewController {
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}

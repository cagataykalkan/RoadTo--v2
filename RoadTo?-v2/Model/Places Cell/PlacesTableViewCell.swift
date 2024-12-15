//
//  PlacesTableViewCellTableViewCell.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var shadowImage: UIImageView!
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        placeImage.addCornerRadius(30)
        shadowImage.addCornerRadius(30)

        
        placeName.font = UIFont(name: K.Fonts.poppinsBlack, size: 48)
        placeName.textColor = UIColor(named: K.BrandColors.darkModeWhite_Grey)
    }
    
    func configure(with place: PlaceData) {
        placeName.text = place.placeName
          placeImage.image = UIImage(named: place.placeImageName)
      }
}

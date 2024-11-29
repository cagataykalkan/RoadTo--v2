//
//  RoutesTableViewCell.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 29.11.2024.
//

import UIKit

class RoutesTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeCategory: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        setupUI()
    }

    func setupUI() {
        numberLabel.font = UIFont(name: K.Fonts.poppinsMedium, size:40 )
        numberLabel.textColor = UIColor(named: K.BrandColors.black2)
        placeNameLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 32)
        placeNameLabel.textColor = UIColor(named: K.BrandColors.black2)
        placeCategory.font = UIFont(name: K.Fonts.poppinsRegular, size: 18)
        placeCategory.textColor = UIColor(named: K.BrandColors.black2)

        
        backView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
        backView.addCornerRadius(30)
    }
    
    func configure(with place: PlaceData, number: Int) {
        numberLabel.text = "\(number)"
        placeNameLabel.text = place.placeName
        placeCategory.text = place.placeCategory // Mekanın kategorisini gösterecek
    }


}

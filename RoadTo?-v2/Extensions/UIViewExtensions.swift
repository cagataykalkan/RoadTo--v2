//
//  UIViewExtensions.swift
//  MovieTrending
//
//  Created by Çağatay KALKAN on 3.10.2024.
//

import Foundation
import UIKit

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(_ color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

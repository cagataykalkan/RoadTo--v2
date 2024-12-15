//
//  Untitled.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 15.12.2024.
//

import UIKit

extension UILabel {
    /// UILabel'de satır aralığı ayarlar
    func setLineSpacing(lineSpacing: CGFloat) {
        // Eğer bir text yoksa işlem yapma
        guard let text = self.text else { return }
        
        // Paragraf stillerini oluştur
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = self.textAlignment  // UILabel hizalamasını korur
        
        // Attributed String oluştur ve ayarları ekle
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: self.textColor ?? UIColor.black,
                .font: self.font ?? UIFont.systemFont(ofSize: 14)
            ]
        )
        
        // UILabel'e Attributed Text'i ata
        self.attributedText = attributedString
    }
}

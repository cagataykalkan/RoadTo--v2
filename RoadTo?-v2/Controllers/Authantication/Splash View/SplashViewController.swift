//
//  SplashViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 25.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SplashViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                //navigate entry
                let vc = EntryPageViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                // navigate welcome
                let vc = WelcomeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    
//    var placeName: String = ""
//    var placeImageName: String = ""
//    var Xcoordinate: String = ""
//    var Ycoordinate: String = ""
//    var isLiked: Bool = false
//    var isSuitableForChild: Bool = true
//    var isSuitableForFamily: Bool = true
//    var placeLocationName: String = ""
//    var placeStar: Double = 5.0
//    var timeToSpend: String = ""
//    var placeExplanation: String = ""
//    var placeCategory: String = ""
//    var placeAddress: String = ""
//    var placeFullName: String = ""

    
    
    func add(){
        let db = Firestore.firestore()
        
        // Otomatik ID ile veri ekleme
        db.collection("places").addDocument(data: [
            "Xcoordinate": "37.78594864108029",
            "Ycoordinate": "29.025301381269312",
            "isLiked": true                        ,
            "isSuitableForChild": true    ,
            "isSuitableForFamily": true   ,
            "placeAddress": "Adalet, Kazım Karabekir Cd. No: 34 B, 20040 Denizli Merkezefendi/Denizli",
            "placeCategory": "Çikolatacı",
            "placeExplanation": "Denizli’nin lezzet dolu dünyasına hoş geldiniz! Buton çikolata, hem göze hem damağa hitap eden benzersiz bir lezzet deneyimi sunuyor. Yüksek kaliteli kakao çekirdeklerinden özenle hazırlanan bu çikolatalar, minik ve şık görünümleriyle her anınıza tat katmak için ideal bir tercih.\n\nDenizli’nin eşsiz dokusunu ve samimi atmosferini yansıtan bu çikolatalar, özel günlerinize zarif bir dokunuş katmak için mükemmel bir seçenek. İster kahvenizin yanında bir keyif molası, ister sevdiklerinize tatlı bir hediye... Buton çikolata, sade şıklığı ve yoğun lezzetiyle her anı unutulmaz kılıyor.\n\nDenizli'den gelen bu lezzeti denemek için daha fazla beklemeyin! 😊",
            "placeImage": "LOGO",
            "placeLocation": "Denizli, Türkiye",
            "placeName": "ARM",
            "placeStar": 5.0,
            "timeToSpend": "30-45",
            "placeFullName": "Bubon Chocolate"
        ]) { error in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
            } else {
                print("Veri başarıyla eklendi.")
            }
        }
    }
}

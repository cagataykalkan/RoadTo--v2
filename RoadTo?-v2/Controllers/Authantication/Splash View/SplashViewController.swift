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
            
            
            
            "Xcoordinate": "38.036403000000",
            "Ycoordinate": "28.953884000000",
            "isLiked": false,
            "isSuitableForChild": true,
            "isSuitableForFamily": true,
            "placeAddress": "Yenicekent Mahallesi, 20400 Buldan, Denizli, Türkiye",
            "placeCategory": "Tarihi Yer",
            "placeExplanation": "Tripolis Antik Kenti, Denizli'nin Buldan ilçesine bağlı Yenicekent Mahallesi'nde yer alan ve Helenistik Dönem'de kurulan önemli bir antik şehirdir. Lidya, Frigya ve Karya bölgelerinin kesişim noktasında bulunan kent, ticaret ve tarım merkezi olarak öne çıkmıştır. Kentte tiyatro, hamam, şehir binası, kale ve surlar gibi yapılar bulunmaktadır. Günümüzde arkeolojik kazılar ve restorasyon çalışmaları devam eden Tripolis, ziyaretçilere antik dönemin izlerini sunmaktadır. :contentReference[oaicite:0]{index=0}",
            "placeImage": "tripolis",
            "placeLocation": "Buldan, Denizli, Türkiye",
            "placeName": "TRİPOLİS ANTİK KENTİ",
            "placeStar": 4.6,
            "timeToSpend": "2-3 Saat",
            "placeFullName": "Tripolis Antik Kenti"
           
            

        ]) { error in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
            } else {
                print("Veri başarıyla eklendi.")
            }
        }
    }
}

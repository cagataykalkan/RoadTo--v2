//
//  WelcomeViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 25.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel2: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = true
        
        let titleLabel = UILabel()
        titleLabel.text = "RoadTo?"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.purple)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        setupUI()
    }

    
    func setupUI() {
        view.backgroundColor = UIColor(named: K.BrandColors.yellow)
        
        nextButton.layer.cornerRadius = 25
        nextButton.backgroundColor = UIColor(named: K.BrandColors.purple)
        nextButton.tintColor = UIColor(named: K.BrandColors.lightPurple)
        nextButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsBold, size: 22)
        
        locationLabel.font = UIFont(name: K.Fonts.poppinsLightItalic, size: 14)
        
        
        welcomeLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        fetchUserNameFromFirestore { userName in
                    if let userName = userName {
                        self.welcomeLabel.text = "Hoşgeldiniz \(userName) 👋, "
                    } else {
                        self.welcomeLabel.text = "Hoşgeldiniz,"
                    }
                }
        welcomeLabel2.font = UIFont(name: K.Fonts.poppinsBlack, size: 24)
        
        
    }
    
    
    // Kullanıcı adını Firestore'dan almak için
       func fetchUserNameFromFirestore(completion: @escaping (String?) -> Void) {
           guard let userID = Auth.auth().currentUser?.uid else {
               completion(nil)
               return
           }
           
           let db = Firestore.firestore()
           db.collection("users").document(userID).getDocument { document, error in
               if let error = error {
                   print("Error getting user name: \(error.localizedDescription)")
                   completion(nil)
               } else if let document = document, document.exists {
                   let userName = document.data()?["name"] as? String
                   completion(userName)
               } else {
                   completion(nil)
               }
           }
       }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let vc = UserInfoSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

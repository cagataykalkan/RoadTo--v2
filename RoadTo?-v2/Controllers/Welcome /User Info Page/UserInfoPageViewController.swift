//
//  UserInfoSettingsViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 25.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class UserInfoPageViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameAnswerLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var surnameAnswerLabel: UILabel!
    @IBOutlet weak var birtdateLabel: UILabel!
    @IBOutlet weak var birtdateAnswerLabel: UILabel!
    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var childAnswerLabel: UILabel!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "RoadTo?"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.yellow)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI() {
        logOutButton.backgroundColor = UIColor(named: K.BrandColors.purple)
        logOutButton.tintColor = UIColor(named: K.BrandColors.lightPurple)
        logOutButton.layer.cornerRadius = 20
        logOutButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsBold, size: 18)
        nameLabel.text = "Adınız"
        nameLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        surnameLabel.text = "Soyadınız"
        surnameLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        birtdateLabel.text = "Doğum Tarihi"
        birtdateLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        childLabel.text = "Çocuk Durumu"
        childLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        
        fetchUserInfoFromFirestore { userInfo in
            if let userInfo = userInfo {
                self.nameAnswerLabel.text = "\(userInfo.name ?? "Bilinmiyor")"
                self.surnameAnswerLabel.text = "\(userInfo.surname ?? "Bilinmiyor")"
                self.birtdateAnswerLabel.text = "\(userInfo.birthDate ?? "Bilinmiyor")"
                self.childAnswerLabel.text = userInfo.child != nil ? (userInfo.child == true ? "Evet" : "Hayır") : "Bilinmiyor"
                
            } else {
                print("Kullanıcı bilgileri alınamadı.")
            }
        }
        
    }
    
    
    
    
    func fetchUserInfoFromFirestore(completion: @escaping (UserInfo?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { document, error in
            if let error = error {
                print("Error fetching user info: \(error.localizedDescription)")
                completion(nil)
            } else if let document = document, document.exists,
                      let data = document.data() {
                let userInfo = UserInfo(data: data)
                completion(userInfo)
            } else {
                completion(nil)
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        let vc = UserInfoEditViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            // Çıkış işlemi başarılı olduğunda kullanıcıyı giriş ekranına yönlendir
            let vc = SplashViewController()
            navigationController?.pushViewController(vc, animated: true)
        } catch
            let error {
                print("Çıkış yapılırken hata oluştu: \(error.localizedDescription)")
            }
        
    }
    
    
    
}

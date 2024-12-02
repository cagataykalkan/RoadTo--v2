//
//  UserInfoEditViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 25.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UserInfoEditViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var birtdateLabel: UILabel!
    @IBOutlet weak var childLabel: UILabel!
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var surnameTextfield: UITextField!
    @IBOutlet weak var birthdateTextfield: UITextField!
    @IBOutlet weak var childSwitch: UISwitch!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var keyboardViewModel: KeyboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard
        keyboardViewModel = KeyboardViewModel(viewController: self)
        keyboardViewModel.addTapGestureToDismissKeyboard()
        
        let titleLabel = UILabel()
        titleLabel.text = "RoadTo?"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.yellow)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        
        setupUI()
    }
    
    
    func setupUI() {
        nameLabel.text = "Adınız"
        nameLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        surnameLabel.text = "Soyadınız"
        surnameLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        birtdateLabel.text = "Doğum Tarihi"
        birtdateLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        childLabel.text = "Çocuk Durumu"
        childLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 16)
        
        saveButton.backgroundColor = UIColor(named: K.BrandColors.purple)
        saveButton.tintColor = UIColor(named: K.BrandColors.lightPurple)
        saveButton.layer.cornerRadius = 20
        saveButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsBold, size: 18)
        
        fetchUserInfoFromFirestore { userInfo in
            if let userInfo = userInfo {
                self.nameTextfield.placeholder = "\(userInfo.name ?? "Bilinmiyor")"
                self.surnameTextfield.placeholder = "\(userInfo.surname ?? "Bilinmiyor")"
                self.birthdateTextfield.placeholder = "\(userInfo.birthDate ?? "Bilinmiyor")"
                self.childSwitch.isOn = userInfo.child == true
                
                
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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        // Boş alanları kontrol etmeden, sadece kullanıcıdan gelen veriyi alalım.
            var updatedData: [String: Any] = [:]
            
            // Name
            if let name = nameTextfield.text, !name.isEmpty {
                updatedData["name"] = name
            }
            
            // Surname
            if let surname = surnameTextfield.text, !surname.isEmpty {
                updatedData["surname"] = surname
            }
            
            // Birthdate
            if let birthdate = birthdateTextfield.text, !birthdate.isEmpty {
                updatedData["birthDate"] = birthdate
            }
            
            // Child (Switch durumu)
            updatedData["child"] = childSwitch.isOn
            
            // Kullanıcı ID'sini al
            guard let userID = Auth.auth().currentUser?.uid else {
                print("Kullanıcı bulunamadı.")
                return
            }
            
            // Firestore referansını al
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userID)
            
            // Sadece dolu alanları güncelle
            userRef.updateData(updatedData) { error in
                if let error = error {
                    print("Veri güncellenirken hata oluştu: \(error.localizedDescription)")
                } else {
                    print("Veri başarıyla güncellendi.")
                    // Başarılı işlem sonrası bir şeyler yapabilirsiniz, örneğin bir uyarı göstermek ya da sayfayı güncellemek.
                }
            }
        
        
        let vc = WelcomeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}

//
//  SurnameViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 24.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SurnameViewController: UIViewController {
    @IBOutlet weak var surnameQuestionLabel: UILabel!
       @IBOutlet weak var surnameTextField: UITextField!
       @IBOutlet weak var button: UIButton!
       
    var userInfo = UserInfo() // Veri modeli
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }

    func setupUI() {
           surnameQuestionLabel.text = "Soyadınızı giriniz."
           surnameQuestionLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
           surnameTextField.placeholder = "Soyadınız"
           button.setTitle("Devam et", for: .normal)
           button.backgroundColor = .black
           button.tintColor = .white
           button.layer.cornerRadius = 20
       }
    
        @IBAction func buttonPressed(_ sender: Any) {
            // Soyad bilgisini alıyoruz
            guard let surname = surnameTextField.text, !surname.isEmpty else {
                showAlert(message: "Soyadınızı giriniz.")
                return
            }
            
            // Soyadı kullanıcı bilgilerine ekliyoruz
            userInfo.surname = surname
            let surnameVC = BirthdateViewController()
                    surnameVC.userInfo = userInfo
                    navigationController?.pushViewController(surnameVC, animated: true)
            
            // Firebase'e kaydediyoruz
           /////////// saveUserInfoToFirebase()
        }
        
//        private func saveUserInfoToFirebase() {
//            // Firebase'e kaydetme işlemi
//            guard let userId = Auth.auth().currentUser?.uid else {
//                showAlert(message: "Kullanıcı ID'si alınamadı.")
//                return
//            }
//
//            let userData: [String: Any] = [
//                "uid": userId,
//                "name": userInfo.name ?? "",
//                "surname": userInfo.surname ?? ""
//            ]
//            
//            // Veriyi Firestore'a kaydediyoruz
//            Firestore.firestore().collection("users").document(userId).setData(userData) { error in
//                if let error = error {
//                    print("Veriler kaydedilemedi: \(error.localizedDescription)")
//                    self.showAlert(message: "Veriler kaydedilemedi.")
//                } else {
//                    print("Veriler başarıyla kaydedildi!")
//                    self.dismiss(animated: true, completion: nil) // Sayfayı kapatıyoruz veya başka bir sayfaya yönlendirebilirsiniz
//                }
//            }
//        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
        }

}

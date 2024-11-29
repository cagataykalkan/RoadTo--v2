//
//  ChildStatusViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 24.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ChildStatusViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var childSwitch: UISwitch!
    
    var keyboardViewModel: KeyboardViewModel!
    
    var userInfo = UserInfo() // Veri modeli
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        keyboardViewModel = KeyboardViewModel(viewController: self)
        keyboardViewModel.addTapGestureToDismissKeyboard()
        
        setupUI()
        self.navigationItem.hidesBackButton = true
        
    }
    
    func setupUI() {
        questionLabel.text = "Çocuk sahibi misiniz?"
        questionLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        button.setTitle("Devam et", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 20
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        var child: Bool
        
        if childSwitch.isOn{
            child = true
        }else{
            child = false
        }
        
        userInfo.child = child
        
        
        saveUserInfoToFirebase()
        
        
        print("olduuuuu")
        
    }
    
    private func saveUserInfoToFirebase() {
        // Firebase'e kaydetme işlemi
        guard let userId = Auth.auth().currentUser?.uid else {
            showAlert(message: "Kullanıcı ID'si alınamadı.")
            return
        }
        
        guard let userMail = Auth.auth().currentUser?.email else {
            showAlert(message: "Kullanıcı mail alınamadı.")
            return
        }
        
        let userData: [String: Any] = [
            "uid": userId,
            "mail": userMail,
            "name": userInfo.name ?? "",
            "surname": userInfo.surname ?? "",
            "birthdate": userInfo.birthDate ?? "",
            "child": userInfo.child ?? ""
        ]
        
        // Veriyi Firestore'a kaydediyoruz
        Firestore.firestore().collection("users").document(userId).setData(userData) { error in
            if let error = error {
                print("Veriler kaydedilemedi: \(error.localizedDescription)")
                self.showAlert(message: "Veriler kaydedilemedi.")
            } else {
                print("Veriler başarıyla kaydedildi!")
                self.dismiss(animated: true, completion: nil) // Sayfayı kapatıyoruz veya başka bir sayfaya yönlendirebilirsiniz
                let vc = WelcomeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

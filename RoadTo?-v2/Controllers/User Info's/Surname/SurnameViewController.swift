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
    
    var keyboardViewModel: KeyboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        keyboardViewModel = KeyboardViewModel(viewController: self)
        keyboardViewModel.addTapGestureToDismissKeyboard()
        self.navigationItem.hidesBackButton = true
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
        
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
}

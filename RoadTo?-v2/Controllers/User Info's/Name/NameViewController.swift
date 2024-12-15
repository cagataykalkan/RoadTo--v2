//
//  NameViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 24.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class NameViewController: UIViewController {
    
    @IBOutlet weak var nameQuestionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
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
        nameQuestionLabel.text = "Adınızı giriniz."
        nameQuestionLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        nameTextField.placeholder = "Adınız"
        
        button.setTitle("Devam et", for: .normal)
        button.backgroundColor = UIColor(named: K.BrandColors.darkModeBlack)
        button.tintColor = UIColor(named: K.BrandColors.darkModeWhite)

        button.layer.cornerRadius = 20
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "Adınızı giriniz.")
            return
        }
        
        userInfo.name = name
        let surnameVC = SurnameViewController()
        surnameVC.userInfo = userInfo
        navigationController?.pushViewController(surnameVC, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
}

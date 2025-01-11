//
//  RegisterPageViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 21.11.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterPageViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var keyboardViewModel: KeyboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardViewModel = KeyboardViewModel(viewController: self)
        keyboardViewModel.addTapGestureToDismissKeyboard()
        setupUI()
    }
    
    
    private func setupUI(){
        welcomeLabel.text = "RoadTo? üyesi olun."
        welcomeLabel.textColor = UIColor(named: K.BrandColors.darkModeBlack)
        welcomeLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        
        emailLabel.text = "E-posta adresi"
        emailLabel.textColor = UIColor(named: K.BrandColors.darkModeBlack)
        emailLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        
        passwordLabel.text = "Parola"
        passwordLabel.textColor = UIColor(named: K.BrandColors.darkModeBlack)
        passwordLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        
        registerButton.backgroundColor = UIColor(named: K.BrandColors.darkModeBlack)
        registerButton.tintColor = UIColor(named: K.BrandColors.darkModeWhite)
        registerButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        registerButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        // Boş alan kontrolü
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen e-posta adresinizi giriniz.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen şifrenizi giriniz.")
            return
        }
        
        // Şifre uzunluk kontrolü
        if password.count < 6 {
            showAlert(title: "Hata", message: "Şifreniz en az 6 karakter olmalıdır.")
            return
        }
        
        // E-posta formatı kontrolü
        if !isValidEmail(email) {
            showAlert(title: "Hata", message: "Lütfen geçerli bir e-posta adresi giriniz.")
            return
        }
        
        // Firebase kayıt işlemi
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let errorMessage: String
                
                switch error.localizedDescription {
                case "The email address is already in use by another account.":
                    errorMessage = "Bu e-posta adresi zaten kullanımda."
                case "The email address is badly formatted.":
                    errorMessage = "E-posta adresi formatı hatalı."
                case "The password must be 6 characters long or more.":
                    errorMessage = "Şifre en az 6 karakter olmalıdır."
                default:
                    errorMessage = "Kayıt olurken bir hata oluştu: \(error.localizedDescription)"
                }
                
                DispatchQueue.main.async {
                    self.showAlert(title: "Hata", message: errorMessage)
                }
                return
            }
            
            // Kayıt başarılı
            DispatchQueue.main.async {
                let nameVC = NameViewController()
                self.navigationController?.pushViewController(nameVC, animated: true)
            }
        }
    }
    
    // E-posta format kontrolü için yardımcı fonksiyon
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Alert helper fonksiyonu
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}

//
//  LoginPageViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 21.11.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginPageViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeLabel2: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var keyboardViewModel: KeyboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        keyboardViewModel = KeyboardViewModel(viewController: self)
        keyboardViewModel.addTapGestureToDismissKeyboard()
    }
    
    
    private func setupUI() {
        
        welcomeLabel.text = "Sizi tekrar görmek çok güzel,"
        welcomeLabel.textColor = UIColor.label
        welcomeLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        
        welcomeLabel2.text = "Hoşgeldiniz."
        welcomeLabel2.textColor = UIColor.label
        welcomeLabel2.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        
        emailLabel.text = "E-posta adresi"
        emailLabel.textColor = UIColor.label
        emailLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        
        passwordLabel.text = "Parola"
        passwordLabel.textColor = UIColor.label
        passwordLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        
        loginButton.backgroundColor = .black
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
        
        registerButton.backgroundColor = .white
        registerButton.tintColor = .black
        registerButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        registerButton.layer.cornerRadius = 20
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let destinationVC = RegisterPageViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        // Boş alan kontrolü
        guard let email = emailTextfield.text, !email.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen e-posta adresinizi giriniz.")
            return
        }
        
        guard let password = passwordTextfield.text, !password.isEmpty else {
            showAlert(title: "Hata", message: "Lütfen şifrenizi giriniz.")
            return
        }
        
        // E-posta formatı kontrolü
        if !isValidEmail(email) {
            showAlert(title: "Hata", message: "Lütfen geçerli bir e-posta adresi giriniz.")
            return
        }
        
        // Firebase giriş işlemi
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let errorMessage: String
                
                switch error.localizedDescription {
                case "The password is invalid or the user does not have a password.":
                    errorMessage = "Şifre hatalı veya eksik."
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    errorMessage = "Bu e-posta adresiyle kayıtlı bir kullanıcı bulunamadı."
                case "The email address is badly formatted.":
                    errorMessage = "E-posta adresi formatı hatalı."
                default:
                    errorMessage = "Giriş yapılırken bir hata oluştu: \(error.localizedDescription)"
                }
                
                DispatchQueue.main.async {
                    self.showAlert(title: "Hata", message: errorMessage)
                }
                return
            }
            
            // Giriş başarılı
            DispatchQueue.main.async {
                let welcomeVC = WelcomeViewController()
                let navigationController = UINavigationController(rootViewController: welcomeVC)
                
                let window = UIApplication.shared.windows.first
                window?.rootViewController = navigationController
                
                UIView.transition(with: window!,
                                duration: 0.3,
                                options: .transitionCrossDissolve,
                                animations: nil,
                                completion: nil)
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

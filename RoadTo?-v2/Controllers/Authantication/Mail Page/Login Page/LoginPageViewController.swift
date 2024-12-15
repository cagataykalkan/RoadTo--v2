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
        if let email = emailTextfield.text , let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    let destinationVC = WelcomeViewController()
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
                
            }
            
        }
    }
    
    
   
}

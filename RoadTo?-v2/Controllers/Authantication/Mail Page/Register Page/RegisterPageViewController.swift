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
        if let email = emailTextField.text , let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    let destinationVC = NameViewController()
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
                
            }
        }
        
        
    }
}

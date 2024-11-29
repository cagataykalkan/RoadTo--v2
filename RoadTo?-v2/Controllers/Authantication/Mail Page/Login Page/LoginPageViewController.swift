//
//  LoginPageViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 21.11.2024.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()


    }

    
    private func setupUI() {
        
        welcomeLabel.text = "Sizi tekrar görmek çok güzel,"
        welcomeLabel.textColor = UIColor(named: K.BrandColors.black3)
        welcomeLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        
        welcomeLabel2.text = "Hoşgeldiniz."
        welcomeLabel2.textColor = UIColor(named: K.BrandColors.black3)
        welcomeLabel2.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        
        emailLabel.text = "E-posta adresi"
        emailLabel.textColor = UIColor(named: K.BrandColors.black2)
        emailLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        
        passwordLabel.text = "Parola"
        passwordLabel.textColor = UIColor(named: K.BrandColors.black2)
        passwordLabel.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        
        loginButton.backgroundColor = .black
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        loginButton.layer.cornerRadius = 20
        
        registerButton.backgroundColor = .white
        registerButton.tintColor = .black
        registerButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        registerButton.layer.cornerRadius = 20
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = UIColor.black.cgColor
    }

   

}

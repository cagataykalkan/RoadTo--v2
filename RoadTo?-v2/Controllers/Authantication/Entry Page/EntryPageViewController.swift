//
//  EntryPageViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 20.11.2024.
//

import UIKit
import FirebaseAuth

class EntryPageViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var signInWithApple: UIButton!
    @IBOutlet weak var signInWithGoogle: UIButton!
    @IBOutlet weak var signInWithMail: UIButton!
    
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var mailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        setupUI()
    }
    
    
    
    func setupUI() {
        welcomeLabel.text = "Seyahatinizi planlamaya başlamak için giriş yapın."
        configureBorder(for: appleView)
        configureBorder(for: googleView)
        configureBorder(for: mailView)
        
    }
    
    func configureBorder(for view: UIView) {
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 30
        view.layer.borderColor = UIColor(named: K.BrandColors.darkModeBlack)?.cgColor
    }
    
    // Tema değiştiğinde tetiklenir
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Eğer tema değişmişse border'ı yeniden yapılandır
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            configureBorder(for: appleView)
            configureBorder(for: googleView)
            configureBorder(for: mailView)
        }
    }
    
    @IBAction func signInWithMailPressed(_ sender: Any) {
        let destinationVC = LoginPageViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    @IBAction func anonymousButton(_ sender: Any) {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("Anonim giriş başarısız: \(error.localizedDescription)")
                return
            }
            
            // Giriş başarılı
            if let user = authResult?.user {
                let isAnonymous = user.isAnonymous  // Kullanıcının anonim olup olmadığını kontrol et
                let uid = user.uid 
                print("Anonim giriş başarılı! UID: \(uid), Anonim: \(isAnonymous)")
                
                let vc = WelcomeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    
    
    
    
}

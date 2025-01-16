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
        Auth.auth().signInAnonymously { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Hata", message: "Anonim giriş başarısız: \(error.localizedDescription)")
                }
                return
            }
            
            // Giriş başarılı
            if let user = authResult?.user {
                let isAnonymous = user.isAnonymous
                let uid = user.uid
                print("Anonim giriş başarılı! UID: \(uid), Anonim: \(isAnonymous)")
                
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
    }
    
    // Alert helper fonksiyonu
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func signInWithGooglePressed(_ sender: Any) {
        
    }
    
    
    @IBAction func signInWithApplePressed(_ sender: Any) {
        // Alttan gelen modal için yeni bir ViewController oluştur
        let bottomSheet = UIViewController()
        bottomSheet.view.backgroundColor = UIColor(named: K.BrandColors.darkModeBlack)
        bottomSheet.view.layer.cornerRadius = 20
        bottomSheet.view.layer.masksToBounds = true
        
        // Mesaj etiketi
        let messageLabel = UILabel()
        messageLabel.text = "Şu an Apple ile giriş yapamıyoruz 😔"
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor(named: K.BrandColors.darkModeWhite)
        messageLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.view.addSubview(messageLabel)
        
        // Mesajı ortalamak için kısıtlamalar
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: bottomSheet.view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: bottomSheet.view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: bottomSheet.view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: bottomSheet.view.trailingAnchor, constant: -20)
        ])
        
        // iOS 15 ve sonrası için sheet ayarları
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.large()] // Yarı ve tam ekran modları
            sheet.prefersGrabberVisible = true // Tutamaç görünür olsun
        }
        
        // Modal olarak göster
        bottomSheet.modalPresentationStyle = .pageSheet
        present(bottomSheet, animated: true, completion: nil)
    }




}

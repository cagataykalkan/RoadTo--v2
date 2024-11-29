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
        appleView.layer.borderWidth = 2
        appleView.layer.cornerRadius = 30
        googleView.layer.borderWidth = 2
        googleView.layer.cornerRadius = 30
        mailView.layer.borderWidth = 2
        mailView.layer.cornerRadius = 30
    }
    
    
    @IBAction func signInWithMailPressed(_ sender: Any) {
        let destinationVC = LoginPageViewController()
        navigationController?.pushViewController(destinationVC, animated: true)

    }
    
    
    
    
    
    

}

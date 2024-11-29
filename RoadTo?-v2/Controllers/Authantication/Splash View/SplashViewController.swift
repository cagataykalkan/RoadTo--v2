//
//  SplashViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 25.11.2024.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                //navigate entry
                let vc = EntryPageViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                // navigate welcome
                let vc = WelcomeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
}

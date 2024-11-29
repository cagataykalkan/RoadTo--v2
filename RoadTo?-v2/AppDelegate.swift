//
//  AppDelegate.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 20.11.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
      
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let navigationController = UINavigationController(rootViewController: SplashViewController())
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
        
        
        
        
        return true
    }
    
     

}


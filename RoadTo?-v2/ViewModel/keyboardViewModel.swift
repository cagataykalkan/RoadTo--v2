//
//  keyboardViewModel.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 25.11.2024.
//

import Foundation
import UIKit

class KeyboardViewModel {
    
    weak var viewController: UIViewController?

    // ViewController'ı parametre olarak al
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func addTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        viewController?.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        viewController?.view.endEditing(true)  // Klavye kapanır
    }
}


//
//  MapViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 1.12.2024.
//

import UIKit
import SwiftUI

class MapViewController: UIViewController {
    
    var sortedRoute: [Coordinate] = []
    var startCoordinate = Coordinate(x: 0.0,y: 0.0)
    
    //var startCoordinate: Coordinate = Coordinate(x: 37.787810885358496, y: 29.019427994152355) // Başlangıç

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.hidesBackButton = true
        
        // SwiftUI View'i bir UIHostingController'a sar
        let swiftUIView = MapSwiftUIView(sortedRoute: sortedRoute, userLocation: startCoordinate)
//        let swiftUIView = MapSwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // HostingController'ı ekle
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // SwiftUI View'in çerçevesini ayarla
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
    
    
}

//
//  RoutesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 29.11.2024.
//

import UIKit
import CoreLocation

class RoutesViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var routesTableView: UITableView!
    
    @IBOutlet weak var startButton: UIButton!
    
    var likedPlaces: [PlaceData] = []
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D?
    
    
    
    var startCoordinate = Coordinate(x: 0.0,y: 0.0)
    
    // sortedRoute özelliğini opsiyonel olmayan bir dizi olarak başlatıyoruz
    var sortedRoute: [Coordinate] = []
    
    // LikedPlacesVC'den gelen likedPlaces dizisini alan initializer
    init(likedPlaces: [PlaceData]) {
        self.likedPlaces = likedPlaces
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocation()
        setupUI()
        createRoute()
        setupTableView()
        routesTableView.reloadData()
    }
    
    func getLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // Konum izni istemek
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()  // Kullanıcıdan konum izni istiyoruz
            locationManager.startUpdatingLocation()         // Konum güncellemelerini başlatıyoruz
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userLocation = newLocation.coordinate
        
        // Konum bilgilerini konsola yazdırıyoruz
        print("Kullanıcı Konumu: \(userLocation?.latitude ?? 0), \(userLocation?.longitude ?? 0)")
        startCoordinate.x = userLocation?.latitude ?? 0
        startCoordinate.y = userLocation?.longitude ?? 0
    }
    
    
    func createRoute() {
        // likedPlaces dizisinden koordinatları almak için map fonksiyonu kullanılıyor
        let coordinates = likedPlaces.compactMap { place in
            if let x = Double(place.Xcoordinate), let y = Double(place.Ycoordinate) {
                return Coordinate(x: x, y: y)
            } else {
                print("Geçersiz koordinatlar: \(place.Xcoordinate), \(place.Ycoordinate)")
                return nil
            }
        }
        
        
        // Başlangıç noktasından itibaren en yakın mekanları sıralıyoruz
        sortedRoute = sortByNearestNeighbor(start: startCoordinate, coordinates: coordinates)
        
        // Koordinatlara göre mekanları sıralama
        likedPlaces = sortedRoute.compactMap { coordinate in
            likedPlaces.first {
                Double($0.Xcoordinate) == coordinate.x && Double($0.Ycoordinate) == coordinate.y
            }
        }
        
        // Sıralanan rota çıktısını konsola yazdırıyoruz
        printRoute(start: startCoordinate, sortedRoute: sortedRoute)
        
    }
    
    func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Rotanız"
        titleLabel.font = UIFont(name: K.Fonts.poppinsEkstraBold, size: 28)
        titleLabel.textColor = UIColor(named: K.BrandColors.purple)
        titleLabel.sizeToFit()
        
        self.navigationItem.titleView = titleLabel
        
        startButton.addCornerRadius(20)
        startButton.addBorder(UIColor(named: K.BrandColors.purple)!, width: 4)
        startButton.backgroundColor = .appPurple
        startButton.titleLabel?.font = UIFont(name: K.Fonts.poppinsSemiBold, size: 22 )
    }
    
    
    // İki nokta arasındaki mesafeyi hesaplayan fonksiyon
    func calculateDistance(from start: Coordinate, to point: Coordinate) -> Double {
        let deltaX = point.x - start.x
        let deltaY = point.y - start.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
    
    // Başlangıç noktasından itibaren en yakın noktalara göre sıralama yapan fonksiyon
    func sortByNearestNeighbor(start: Coordinate, coordinates: [Coordinate]) -> [Coordinate] {
        var visited: [Coordinate] = []
        var remaining = coordinates
        var current = start
        
        while !remaining.isEmpty {
            if let nearest = remaining.min(by: { calculateDistance(from: current, to: $0) < calculateDistance(from: current, to: $1) }) {
                visited.append(nearest)
                remaining.removeAll { $0.x == nearest.x && $0.y == nearest.y }
                current = nearest
            }
        }
        return visited
    }
    
    // Rotadaki noktaları yazdıran fonksiyon
    func printRoute(start: Coordinate, sortedRoute: [Coordinate]) {
        print("Başlangıç noktası: (\(start.x), \(start.y))")
        for (index, coordinate) in sortedRoute.enumerated() {
            print("\(index + 1). yer: (\(coordinate.x), \(coordinate.y))")
        }
    }
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        let vc = MapViewController()
        vc.sortedRoute = sortedRoute
        navigationController?.pushViewController(vc, animated: true)
<<<<<<< HEAD
       
=======
//        print(sortedRoute[0].id)
//        print(sortedRoute[1].id)
//        print(sortedRoute[2].id)
//        print(sortedRoute[3].id)
//        print(sortedRoute[4].id)
>>>>>>> main
    }
    
    
}
 

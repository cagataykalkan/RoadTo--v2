//
//  RoutesViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 29.11.2024.
//

import UIKit

class RoutesViewController: UIViewController {
    
    @IBOutlet weak var routesTableView: UITableView!
    
    @IBOutlet weak var startButton: UIButton!
    
    var likedPlaces: [PlaceData] = []
    let startCoordinate = Coordinate(x: 0, y: 0) // Başlangıç koordinatları örnek olarak 0,0
    
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
        
        setupUI()
                
        // TableView ayarları
        setupTableView()
        
        routesTableView.reloadData()
        
        // likedPlaces dizisinden koordinatları almak için map fonksiyonu kullanılıyor
        let coordinates = likedPlaces.map { place in
            return Coordinate(x: Double(place.Xcoordinate) ?? 0.0, y: Double(place.Ycoordinate) ?? 0.0)
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
            print("Kalan noktalar: \(remaining)")
            if let nearest = remaining.min(by: { calculateDistance(from: current, to: $0) < calculateDistance(from: current, to: $1) }) {
                print("En yakın nokta: \(nearest)")
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
    }
    
    
}

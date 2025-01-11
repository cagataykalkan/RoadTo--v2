//
//  LocationService.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 15.12.2024.
//

//
//  LocationService.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 15.12.2024.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    var onLocationUpdate: ((CLLocation) -> Void)?  // Konum güncelleme callback'i
    var onCityUpdate: ((String) -> Void)?  // Şehir adı güncelleme callback'i
    var currentLocation: CLLocation? // Mevcut konum
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    /// Konum izleme işlemini başlatır
    func startUpdatingLocation() {
        // Önce yetkilendirme durumunu kontrol et
        checkLocationAuthorization()
    }

    /// Konum izleme işlemini durdurur
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    // MARK: - Private Methods

    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Konum izni reddedildi veya kısıtlandı.")
        @unknown default:
            print("Bilinmeyen bir durum oluştu.")
        }
    }

    // MARK: - CLLocationManagerDelegate

    /// Yeni konum bilgisi geldiğinde çağrılır
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Konum güncellendi: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // Callback ile konumu döndür
        currentLocation = location
        onLocationUpdate?(location)
        
        // Şehir adını bul ve döndür
        fetchCityName(from: location)
    }

    /// Konum güncellemesi sırasında hata oluşursa çağrılır
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Konum alınırken hata oluştu: \(error.localizedDescription)")
    }

    /// Kullanıcı izni durum değişikliği olduğunda çağrılır
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    // MARK: - Şehir Bilgisi Alımı

    /// Konumdan şehir adını almak için CLGeocoder kullanır
    private func fetchCityName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Geocode hatası: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                // İl (şehir) bilgisi
                let city = placemark.administrativeArea ?? "Bilinmiyor"
                
                // İlçe bilgisi
                let district = placemark.subAdministrativeArea ?? "Bilinmiyor"
                
                print("Bulunan şehir (il): \(city), ilçe: \(district)")
                
                // Callback ile şehir ve ilçe adını döndür
                self?.onCityUpdate?("\(city), \(district)")
            } else {
                print("Şehir veya ilçe bilgisi alınamadı.")
            }
        }
    }
}

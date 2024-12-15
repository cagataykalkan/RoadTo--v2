//
//  DataManager.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 28.11.2024.
//

import FirebaseFirestore

class DataManager {
    static let shared = DataManager() // Singleton örneği
    private init() {}

    var places: [PlaceData] = []

    // Firestore'dan veriyi bir kere çekme
    func fetchPlacesFromFirestore(completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()

        // "places" koleksiyonundaki belgeleri çek
        db.collection("places").getDocuments { (snapshot, error) in
            if let error = error {
                print("Firestore Hatası: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let documents = snapshot?.documents else {
                print("Veriler alınamadı.")
                completion(false)
                return
            }

            // Verileri model objelerine dönüştür
            self.places = documents.compactMap { doc -> PlaceData? in
                let data = doc.data()

                // Veriyi loglayarak kontrol edin
                //print("Veri: \(data)")

                // Veri alanlarını güvenli bir şekilde çıkartalım
                let placeName = data["placeName"] as? String ?? ""
                let placeImageName = data["placeImage"] as? String ?? ""
                let isLiked = data["isLiked"] as? Bool ?? false
                let isSuitableForChild = data["isSuitableForChild"] as? Bool ?? false
                let isSuitableForFamily = data["isSuitableForFamily"] as? Bool ?? false
                let placeLocationName = data["placeLocation"] as? String ?? ""
                let placeStar = data["placeStar"] as? Double ?? 0.0
                let timeToSpend = data["timeToSpend"] as? String ?? ""
                let Xcoordinate = data["Xcoordinate"] as? String ?? ""
                let Ycoordinate = data["Ycoordinate"] as? String ?? ""
                let placeExplanation = data["placeExplanation"] as? String ?? ""
                let placeCategory = data["placeCategory"] as? String ?? ""
                let placeAddress = data["placeAddress"] as? String ?? ""
                let placeFullName = data["placeFullName"] as? String ?? ""


                // Modeli oluştur
                return PlaceData(
                    placeID: doc.documentID,
                    placeName: placeName,
                    placeImageName: placeImageName,
                    Xcoordinate: Xcoordinate,
                    Ycoordinate: Ycoordinate,
                    isLiked: isLiked,
                    isSuitableForChild: isSuitableForChild,
                    isSuitableForFamily: isSuitableForFamily,
                    placeLocationName: placeLocationName,
                    placeStar: placeStar,
                    timeToSpend: timeToSpend,
                    placeExplanation: placeExplanation,
                    placeCategory: placeCategory,
                    placeAddress: placeAddress,
                    placeFullName: placeFullName
                )
            }

            // Verinin doğru şekilde modele dönüştürülüp dönüştürülmediğini kontrol et
            //print("Veri modele dönüştü: \(self.places)")

            // İşlem tamamlandığında başarıyı bildir
            completion(true)
        }
    }
}

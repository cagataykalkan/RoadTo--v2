//
//  UserInfo.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 24.11.2024.
//

class UserInfo {
    var name: String?
    var surname: String?
    var birthDate: String?
    var child: Bool?
    
    init() {}
    
    // Opsiyonel verilerle çalışmak için init'i güncelledik
    init(data: [String: Any]) {
        self.name = data["name"] as? String
        self.surname = data["surname"] as? String
        self.birthDate = data["birthdate"] as? String
        self.child = data["child"] as? Bool
    }
}


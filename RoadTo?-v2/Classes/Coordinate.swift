//
//  Coordinate.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 29.11.2024.
//

import MapKit

class Coordinate: Identifiable, Equatable {
    var id = UUID()
    var x: Double
    var y: Double
    var name: String?
        
    init(id: UUID = UUID(), x: Double, y: Double) {
        self.id = id
        self.x = x
        self.y = y
    }
    
    init(id: UUID = UUID(), x: Double, y: Double, name: String) {
        self.id = id
        self.x = x
        self.y = y
        self.name = name
        }
    
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}



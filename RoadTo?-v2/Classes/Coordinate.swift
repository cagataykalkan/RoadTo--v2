//
//  Coordinate.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 29.11.2024.
//
import MapKit



import MapKit

struct Coordinate: Identifiable, Equatable {
    var id = UUID()
    var x: Double
    var y: Double
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

//
//  PlaceData.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 27.11.2024.
//

import Foundation

import Foundation

class PlaceData {
    var placeID: String = ""
    var placeName: String = ""
    var placeImageName: String = ""
    var Xcoordinate: String = ""
    var Ycoordinate: String = ""
    var isLiked: Bool = false
    var isSuitableForChild: Bool = true
    var isSuitableForFamily: Bool = true
    var placeLocationName: String = ""
    var placeStar: Double = 5.0
    var timeToSpend: String = ""
    var placeExplanation: String = ""
    var placeCategory: String = ""
    

    init(placeID: String, placeName: String, placeImageName: String, Xcoordinate: String, Ycoordinate: String, isLiked: Bool, isSuitableForChild: Bool, isSuitableForFamily: Bool, placeLocationName: String, placeStar: Double, timeToSpend: String, placeExplanation: String, placeCategory: String) {
        self.placeID = placeID
        self.placeName = placeName
        self.placeImageName = placeImageName
        self.Xcoordinate = Xcoordinate
        self.Ycoordinate = Ycoordinate
        self.isLiked = isLiked
        self.isSuitableForChild = isSuitableForChild
        self.isSuitableForFamily = isSuitableForFamily
        self.placeLocationName = placeLocationName
        self.placeStar = placeStar
        self.timeToSpend = timeToSpend
        self.placeExplanation = placeExplanation
        self.placeCategory = placeCategory
    }
}

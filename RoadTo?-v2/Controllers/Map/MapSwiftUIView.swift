//
//  MapSwiftUIView.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 1.12.2024.
//

import SwiftUI
import MapKit

struct MapSwiftUIView: View {
    var sortedRoute: [Coordinate]
    var userLocation: Coordinate
    
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion.myRegion(for: .init(x: 0, y: 0)))
    @State private var mapSelection: MKMapItem?
    @State private var showDetails: Bool = false
    @State private var getDirections = false
    
    var mapItems: [MKMapItem] {
        sortedRoute.compactMap { location in
            location.toMapItem(name: location.name ?? "Bilinmeyen Durak")
        }
    }

    var body: some View {
        ZStack {
            Map(position: $cameraPosition, selection: $mapSelection) {
                // Başlangıç konumunu işaretleyelim
                Annotation("Başlangıç", coordinate: userLocation.toCLLocationCoordinate2D()) {
                    ZStack {
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.blue.opacity(0.25))
                        
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                        
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.blue)
                    }
                }
                
                // Rota üzerindeki diğer duraklar
                ForEach(Array(mapItems.enumerated()), id: \.1) { index, mapItem in
                    if let coordinate = mapItem.placemark.location?.coordinate {
                        Marker(mapItem.name ?? "Durak", systemImage: "\(index + 1).circle.fill", coordinate: coordinate)
                    }
                }
            }
        }
        .onChange(of: mapSelection) { _, newValue in
            showDetails = newValue != nil
        }
        .sheet(isPresented: $showDetails) {
            if let mapSelection {
                MapLocationDetailsSwiftUIView(mapSelection: mapSelection, show: $showDetails, getDirections: $getDirections)
                    .presentationDetents([.height(340)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                    .presentationCornerRadius(12)
            }
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
            MapPitchToggle()
        }
        .onAppear {
            cameraPosition = .region(MKCoordinateRegion.myRegion(for: userLocation))
        }
    }
}

extension MKCoordinateRegion {
    static func myRegion(for userLocation: Coordinate) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: userLocation.toCLLocationCoordinate2D(),
            latitudinalMeters: 30000,
            longitudinalMeters: 30000
        )
    }
}

extension Coordinate {
    func toMapItem(name: String) -> MKMapItem {
        let coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
    
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: x, longitude: y)
    }
}


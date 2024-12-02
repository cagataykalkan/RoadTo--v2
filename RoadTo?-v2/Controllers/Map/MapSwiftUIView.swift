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
    
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @State private var mapSelection: MKMapItem?
    @State private var showDetails: Bool = false
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    var mapItems: [MKMapItem] {
        sortedRoute.enumerated().map { index, location in
            location.toMapItem(name: "\(index + 1). Durak")
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition, selection: $mapSelection) {
                // Başlangıç konumunu işaretleyelim
                Annotation("Başlangıç", coordinate: .myLocation) {
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
                ForEach(mapItems, id: \.self) { mapItem in
                    if routeDisplaying {
                        if mapItem == routeDestination {
                            if let coordinate = mapItem.placemark.location?.coordinate {
                                Marker(mapItem.name ?? "Durak", coordinate: coordinate)
                            }
                        }
                    } else {
                        if let coordinate = mapItem.placemark.location?.coordinate {
                            Marker(mapItem.name ?? "Durak", coordinate: coordinate)
                        }
                    }
                }
                
                if let route {
                    MapPolygon(route.polyline)
                        .stroke(.blue, lineWidth: 7)
                }
            }
        }
        .onChange(of: getDirections) { oldValue, newValue in
            if newValue == true {
                Task {
                    await fetchRoute()
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
    }
}

extension MapSwiftUIView {
    func fetchRoute() async {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: .myLocation))
            request.destination = mapSelection
            
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            routeDestination = mapSelection
            
            withAnimation(.snappy) {
                routeDisplaying = true
                showDetails = false
                
                if let rect = route?.polyline.boundingMapRect, routeDisplaying {
                    cameraPosition = .rect(rect)
                }
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 37.787810885358496, longitude: 29.019427994152355)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: .myLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
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
}
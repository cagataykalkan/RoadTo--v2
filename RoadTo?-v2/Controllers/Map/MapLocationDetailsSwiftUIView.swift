//
//  MapLocationDetailsSwiftUIView.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 2.12.2024.
//

import SwiftUI
import MapKit

struct MapLocationDetailsSwiftUIView: View {
    
    var mapSelection: MKMapItem
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    @Binding var getDirections: Bool
    @State private var placeAddress: String?
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(mapSelection.name ?? "Bilinmeyen Lokasyon")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(placeAddress ?? "Adres bilgisi mevcut değil.")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                
                Spacer()
                
                Button {
                    show.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            .padding()
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("Ön izleme mevcut değil.", systemImage: "eye.slash")
            }
            
            HStack(spacing: 24){
                Button{
                        mapSelection.openInMaps()
                }label: {
                    Text("Haritalarda aç")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 170, height: 48)
                        .background(.green)
                        .cornerRadius(12)
                }
                
//                Button{
//                    getDirections = true
//                    show = false
//                }label: {
//                    Text("Yol tarifi al")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(width: 170, height: 48)
//                        .background(.blue)
//                        .cornerRadius(12)
//                }
            }
        }
        .onAppear {
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection) { newValue in
            fetchPlaceAddress(for: newValue)
        }
        .onAppear {
            fetchPlaceAddress(for: mapSelection)
        }
    }
}

extension MapLocationDetailsSwiftUIView {
    func fetchLookAroundPreview() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: mapSelection)
            lookAroundScene = try? await request.scene
        }
    }
    
    func fetchPlaceAddress(for mapItem: MKMapItem) {
            // DataManager'dan veriyi al ve uygun adresi bul
            if let selectedPlace = DataManager.shared.places.first(where: { place in
                place.placeName == mapItem.name
            }) {
                placeAddress = selectedPlace.placeAddress
            } else {
                placeAddress = "Adres bilgisi mevcut değil."
            }
        }
}


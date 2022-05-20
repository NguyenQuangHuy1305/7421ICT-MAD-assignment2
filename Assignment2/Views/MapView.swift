//
//  MapView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 13/5/2022.
//

import SwiftUI
import MapKit

// [place] <-> [Location]

struct MapView: View {
    
    @Environment(\.editMode) var editMode
    
    @Binding var coordinates: CLLocationCoordinate2D
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
    let formatter: NumberFormatter = {
        let temp = NumberFormatter()
        temp.allowsFloats = true
        temp.numberStyle = .decimal
        return temp
    }()

    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            
            if editMode?.wrappedValue == .active {
                HStack {
                    Text("Latitude:")
                    TextField("Latitude: ", text: $region.latitudeString) {
                        coordinates.latitude = region.center.latitude
                    }
                }
                HStack {
                    Text("Longitude:")
                    TextField("Longitude: ", text: $region.longitudeString) {
                        coordinates.longitude = region.center.longitude
                    }
                }.onDisappear {
                    coordinates = region.center
                }
            } else {
                HStack {
                    Text("Latitude: \(region.center.latitude)")
                }
                HStack {
                    Text("Longitude: \(region.center.longitude)")
                }
            }
        }.onAppear {
            region.center = coordinates
        }
    }
    
//    func saveLatitude() {
//        if let newLatitude = Double(newLatitude) {
//            place.latitudeText = newLatitude
//        } else {
//            fatalError("Invalid input")
//        }
//    }
}

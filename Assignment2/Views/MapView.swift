//
//  MapView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 13/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment(\.editMode) var editMode
    
    @Binding var region: MKCoordinateRegion
    
    @State var region2: MKCoordinateRegion
    
//    @State var region2: MKCoordinateRegion = MKCoordinateRegion()
//    
//    @State var latitudeTemp: String = region.latitudeString
//
//    @State var longitudeTemp: String = region.longitudeString
    
    var body: some View {
        Map(coordinateRegion: $region2)
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        
        if editMode?.wrappedValue == .active {
            HStack {
                Text("Latitude:")
                TextField("Latitude: ", text: $region.latitudeString)
            }
            HStack {
                Text("Longitude:")
                TextField("Longitude: ", text: $region.longitudeString)
            }
        } else {
            HStack {
                Text("Latitude: \(region2.latitudeString)")
            }
            HStack {
                Text("Longitude: \(region2.longitudeString)")
            }
        }
    }
}

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
    
    /// var we got from PlaceView
    @Binding var coordinates: CLLocationCoordinate2D
    
    /// initiate the region for Map(), the initial latitude and longitude will be 0, will be replace later with .onAppear(), the latitude and longitude comes from coordinate var
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
    /// this formatter is currently unused
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
            
            /// if the user enter editmode, they can change latitude and longitude OF THE VAR COORDINATES, not of region, latitude and longitude FROM COORDINATES will later be injected to region .onAppear(). The reason we need to do this, is bcs if we change region.latitude and region.longitude directly, the PlaceView got redrawn -> we got kicked out of MapView
            if editMode?.wrappedValue == .active {
                HStack {
                    Text("Latitude:")
                    TextField("Latitude: ", text: $region.latitudeString) {
                        /// when text in TextField changed, assign latitude to coordinates.latitude
                        coordinates.latitude = region.center.latitude
                    }
                }
                HStack {
                    Text("Longitude:")
                    TextField("Longitude: ", text: $region.longitudeString) {
                        /// when text in TextField changed, assign longitude to coordinates.longitude
                        coordinates.longitude = region.center.longitude
                    }
                }.onDisappear {
                    /// only when the user exit editmode, the value from the current region (current map) will be injected to var coordinates
                    coordinates = region.center
                }
            } else {
                /// if the user is not in editmode, only display lat and lon as string Text
                HStack {
                    Text("Latitude: \(region.center.latitude)")
                }
                HStack {
                    Text("Longitude: \(region.center.longitude)")
                }
            }
        }.onAppear {
            /// everytime MapView is loaded, latitude and longitude from var coordinate will be "injected"" to var region
            region.center = coordinates
        }
    }
}

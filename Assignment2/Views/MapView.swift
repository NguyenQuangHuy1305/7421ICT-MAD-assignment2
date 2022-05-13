//
//  MapView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 13/5/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            .ignoresSafeArea()
        HStack {
            Text("Latitude:")
            TextField("Latitude: ", text: $region.latitudeString)
        }
        HStack {
            Text("Longitude:")
            TextField("Longitude: ", text: $region.longitudeString)
        }
    }
}

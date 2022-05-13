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
        TextField("Latitude: ", text: $region.latitudeString)
        TextField("Longitude: ", text: $region.longitudeString)
    }
}

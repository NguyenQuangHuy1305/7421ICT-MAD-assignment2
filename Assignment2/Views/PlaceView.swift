//
//  PlaceView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import SwiftUI
import MapKit

struct PlaceView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    @State var image = Image(systemName: "photo")
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.47, longitude: 153.02), latitudinalMeters: 5000, longitudinalMeters: 5000)

    
    var body: some View {
        List {
            Section {
                if editMode?.wrappedValue == .active {
                    TextField("Enter place's name", text: $place.placeName)
                    TextField("Enter place's location", text: $place.placeLocation)
                    TextField("Enter place's note", text: $place.placeNote)
                    TextField("Enter place's image URL", text: $place.urlString)
                } else {
                    Text(place.placeLocation)
                    Text(place.placeNote)
                    image.aspectRatio(contentMode: .fit)
                }
            }
            Section {
                Map(coordinateRegion: $region)
                TextField("Latitude: ", text: $region.latitudeString)
                TextField("Longitude: ", text: $region.longitudeString)
            }
        }
        .navigationTitle(place.placeName)
        .task {
            image = await place.getImage()
        }
    }
}

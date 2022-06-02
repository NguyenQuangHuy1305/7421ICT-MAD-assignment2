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
    @State var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    
    /// formatter to format text to float, useful when the user input an invalid Double, which will return nothing
    let formatter: NumberFormatter = {
        let temp = NumberFormatter()
        temp.allowsFloats = true
        temp.numberStyle = .decimal
        return temp
    }()
        
//    @State var regionMini = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 5000, longitudinalMeters: 5000)
//    @State var coordinate = CLLocationCoordinate2D(latitude: place.placeLatitude, longitude: place.placeLongitude)
    
    var body: some View {
        List {
            /// if the user press the edit button, display TextField() instead of Text()
            if editMode?.wrappedValue == .active {
                HStack {
                    Text("Place's name: ")
                    TextField("Enter place's name", text: $place.placeName)
                }
                HStack {
                    Text("Place's location: ")
                    TextField("Enter place's location", text: $place.placeLocation)
                }
                HStack {
                    Text("Place's note: ")
                    TextField("Enter place's note", text: $place.placeNote)
                }
                HStack {
                    Text("Place's image URL: ")
                    TextField("Enter place's image URL", text: $place.urlString)
                }
                HStack {
                    Text("Latitude: ")
                    /// ultilize the formatter to ensure user doesn't input non decimal values
                    TextField("Enter place's latitude", value: $place.placeLatitude, formatter: formatter)
                }
                HStack {
                    Text("Longitude: ")
                    /// ultilize the formatter to ensure user doesn't input non decimal values
                    TextField("Enter place's longitude", value: $place.placeLongitude, formatter: formatter)
                }
                .onDisappear {
//                    place.lookUpCoordinates(for: place.placeName)
                    place.lookUpName(for: place.coordinate)
                }
            } else {
                Text(place.placeLocation)
                Text(place.placeNote)
                ///  fit the image
                image.aspectRatio(contentMode: .fit)
                HStack {
                    Text("Latitude: ")
                    Text("\(place.placeLatitude)")
                }
                HStack {
                    Text("Longitude: ")
                    Text("\(place.placeLongitude)")
                }
                Button("Look up sunrise and sunset") {
                    place.lookUpSunriseSunset()
                }
            }
            NavigationLink {
                /// pass the place.coordinate into MapView, which contain ONLY the latitude and longitude of current Place
                MapView(coordinates: $place.coordinate, place: place)
            } label: {
                HStack {
                    /// use Map() function with place.regionMini, which is a var that only have getter (setter does nothing) --> for displaying miniMap ONLY
                    Map(coordinateRegion: $place.regionMini).frame(width: 100, height: 50)
                    Text("\(place.placeName)'s map")
                }
            }
        }
        .navigationTitle(place.placeName)
        .task {
            image = await place.getImage()
        }
    }
}

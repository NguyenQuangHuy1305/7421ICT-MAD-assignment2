//
//  MapView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 13/5/2022.
//

import SwiftUI
import MapKit
import CoreLocation


//struct SomeView: View {
//    
//    @ObservedObjecrt var viewModel: ViewModel
//    
//    var body: some View {
//        TextField("", value: $viewModel.latitude, formatter: Formatter())
//    }
//    
//}

struct MapView: View {
    
    @Environment(\.editMode) var editMode
    
    /// var we got from PlaceView
    @Binding var coordinates: CLLocationCoordinate2D
    /// place passed in from ContentView -> PlaceView -> MapView
    @ObservedObject var place: Place
    
    @State var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")

    /// initiate the region for Map(), the initial latitude and longitude will be 0, will be replace later with .onAppear(), the latitude and longitude comes from coordinate var
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 5000, longitudinalMeters: 5000)
    
    @State var nameTemp = ""
        
    /// this formatter is currently unused
    let formatter: NumberFormatter = {
        let temp = NumberFormatter()
        temp.allowsFloats = true
        temp.numberStyle = .decimal
        return temp
    }()

    var body: some View {
        VStack {
            if editMode?.wrappedValue == .active {
                HStack {
                    Button {
                        place.lookUpName(for: region.center)
                    } label: {
                        Label("Place name: ", systemImage: "text.magnifyingglass")
                    }
                    TextField("Enter place's name", text: $nameTemp)
                }
            }
            
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }.navigationTitle("Map of \(place.placeName)")

            
            /// if the user enter editmode, they can change latitude and longitude OF THE VAR COORDINATES, not of region, latitude and longitude FROM COORDINATES will later be injected to region .onAppear(). The reason we need to do this, is bcs if we change region.latitude and region.longitude directly, the PlaceView got redrawn -> we got kicked out of MapView
            if editMode?.wrappedValue == .active {
                VStack {
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
                    }
                    Button("Search coordinate", action: {
                        /// when this button is clicked, assign the current nameTemp (whatevver is currently in the TextField) to place.placeName
                        place.placeName = nameTemp
                        /// then call this
                        place.lookUpCoordinates(for: place.placeName)
                    })
                }
                .onDisappear {
                    /// only when the user exit editmode, the value from the current region (current map) will be injected to var coordinates
                    /// then the MapView will still redraw --> we stil lgot kicked out of MapView
                    coordinates = region.center
//                    place.placeName = nameTemp
//                    place.lookUpCoordinates(for: place.placeName)
                }
            } else {
                /// if the user is not in editmode, only display lat and lon as string Text
                HStack {
                    Text("Latitude: \(region.center.latitude)")
                }
                HStack {
                    Text("Longitude: \(region.center.longitude)")
                }
                HStack {
                    Label(sunriseSunset.sunrise, systemImage: "sunrise")
                    Spacer()
                    Label(sunriseSunset.sunset, systemImage: "sunset")
                }
                Button("Look up sunrise and sunset") {
                    lookUpSunriseSunset()
                }
            }
        }.onAppear {
            /// everytime MapView is loaded, latitude and longitude from var coordinate will be "injected"" to var region
            region.center = coordinates
        }
    }
    
    func lookUpSunriseSunset() {
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(place.placeLatitude)&lng=\(place.placeLongitude)"
        guard let url = URL(string: urlString) else {
            print("Malformed URL: \(urlString)")
            return
        }
        guard let jsonData = try? Data(contentsOf: url) else {
            print("Could not look up sunrise and sunset")
            return
        }
        guard let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from:jsonData) else {
            print("Could not decode JSON API data")
            return
        }
        sunriseSunset = api.results
//        return api.results
    }
}

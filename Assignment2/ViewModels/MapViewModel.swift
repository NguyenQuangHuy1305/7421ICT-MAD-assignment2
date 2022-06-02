//
//  MapViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 2/6/2022.
//

import Foundation
import CoreData
import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    
    @Published var place: Place
    
//    @Published var placeName: String
//
//    @Published var coordinates: CLLocationCoordinate2D

    @Published var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    
//    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 5000, longitudinalMeters: 5000)

    @Published var nameTemp = ""

    init(_ place: Place) {
        self.place = place
//        self.coordinates = place.coordinate
//        self.placeName = place.placeName
    }
    
    func lookUpSunriseSunset() async -> SunriseSunset {
        let urlString = "https://api.sunrise-sunset.org/json?lat=\(place.placeLatitude)&lng=\(place.placeLongitude)"
        guard let url = URL(string: urlString) else {
            print("Malformed URL: \(urlString)")
            return sunriseSunset
        }
        guard let jsonData = try? Data(contentsOf: url) else {
            print("Could not look up sunrise and sunset")
            return sunriseSunset
        }
        guard let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from:jsonData) else {
            print("Could not decode JSON API data")
            return sunriseSunset
        }
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        // think of another way to get current timezone
        outputFormatter.timeZone = .current
        
        var converted = api.results
        
        if let time = inputFormatter.date(from: api.results.sunrise) {
            converted.sunrise = outputFormatter.string(from: time)
        }
        if let time = inputFormatter.date(from: api.results.sunset) {
            converted.sunset = outputFormatter.string(from: time)
        }
        sunriseSunset = converted
        return sunriseSunset
    }
    
    func lookUpCoordinates(for placeName: String) {
        let coder = CLGeocoder()
        coder.geocodeAddressString(placeName) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(placeName): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            /// only get the 1st palcemark
            let placemark = placemarks[0]
            guard let location = placemark.location else {
                print("Placemark has no location")
                return
            }
            
            /// since coordinate only accept CLLocationCoordinate2D, and the returned location (in this func) is CLLocation, I need to convert from CLLocation to CLLocationCoordinate2D
            let stuff = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.place.coordinate = stuff
        }
    }
    
    func lookUpName(for coordinate: CLLocationCoordinate2D) {
        let stuff = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(stuff) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(coordinate): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            self.place.placeName = placemark.name ?? placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }
}

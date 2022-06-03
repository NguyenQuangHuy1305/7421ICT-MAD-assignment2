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

    @Published var sunriseSunset = SunriseSunset(sunrise: "unknown", sunset: "unknown")
    
    @Published var nameTemp = ""

    init(_ place: Place) {
        self.place = place
    }
    
    /// Func to:
    /// 1: use place.placeLatitude (and lon) to create a string (url),
    /// 2: get Data(contentsOf: url)
    /// 3: use JSON decoder to decode that data into SunriseSunsetAPI struct
    /// - Returns: async funcs have to return something, so I set it to return SunriseSunset (unused return)
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
        
        /// since the data we got from the SunriseSunset API is in weird forms (still string), we need to 1st convert that string (both sunrise string and sunset string)  into desided date form, then convert back from date form to string to display
        let inputFormatter = DateFormatter()
        inputFormatter.dateStyle = .none
        inputFormatter.timeStyle = .medium
        inputFormatter.timeZone = .init(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .medium
        outputFormatter.timeZone = .current
        
        var converted = api.results
        
        /// 1: time = return a date representation of a specified string (api.results.sunrise) according to inputFormatter settings
        /// 2: converted.sunrise = return a string representation of a specified date (apt.results.sunrise) according to outputFormatter settings
        if let time = inputFormatter.date(from: api.results.sunrise) {
            converted.sunrise = outputFormatter.string(from: time)
        }
        
        /// 1: time = return a date representation of a specified string (api.results.sunset) according to inputFormatter settings
        /// 2: converted.sunrise = return a string representation of a specified date (apt.results.sunset) according to outputFormatter settings
        if let time = inputFormatter.date(from: api.results.sunset) {
            converted.sunset = outputFormatter.string(from: time)
        }
        sunriseSunset = converted
        return sunriseSunset
    }
    
    /// Func to lookup coordinate when given a placeName: String
    /// - Parameter placeName: placeName is from place.placeName (MapView model contain a reference of place)
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
            
            /// since place.coordinate only accept CLLocationCoordinate2D, and the returned location (in this func line 88) is of CLLocation type, I need to convert from CLLocation to CLLocationCoordinate2D so that we can update place.coordinate
            let stuff = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.place.coordinate = stuff
        }
    }
    
    /// Func to lookup a placeName when given a CLLocationCoordinate2D
    /// - Parameter coordinate: coordinate here will be region.center (where the MapView is currently showing) used in MapView
    func lookUpName(for coordinate: CLLocationCoordinate2D) {
        
        /// since reverseGeocodeLocation only accept CLLocation type data, we need to convert CLLocationCoordinate2D data to CLLocation data
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

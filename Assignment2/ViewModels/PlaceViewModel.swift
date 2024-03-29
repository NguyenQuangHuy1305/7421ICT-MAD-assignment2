//
//  PlaceViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import CoreData
import SwiftUI
import MapKit

let defaultImage = Image(systemName: "photo")
var downloadedImages = [URL : Image]()

/// extension for Place (which is a class)
/// also act as a ViewModel to store all func relating to PlaceView
extension Place {
    /// viewModel's property for "name" database attribute
    var placeName: String {
        get { name ?? "Enter new place's name here" }
        set {
            name = newValue
            save()
        }
    }
    
    /// viewModel's property for "location" database attribute
    var placeLocation: String {
        get { location ?? "Input the location here" }
        set {
            location = newValue
            save()
        }
    }
    
    /// viewModel's property for "note" database attribute
    var placeNote: String {
        get { note ?? "Input your note here"}
        set {
            note = newValue
            save()
        }
    }
    
    /// viewModel's property for "imageURL" database attribute
    var urlString: String{
        get { imageURL?.absoluteString ?? "Input your URL here"}
        set {
            guard let url = URL(string: newValue) else { return }
            imageURL = url
            save()
        }
    }
    
    /// viewModel's property for "latitudeText" database attribute
    var placeLatitude: Double {
        get { latitude }
        set {
//            guard let latitudeText = Double(newValue) else {return}
            latitude = newValue
            save()
        }
    }

    /// viewModel's property for "longitudeText" database attribute
    var placeLongitude: Double {
        get { longitude }
        set {
            longitude = newValue
            save()
        }
    }
    
    /// regionMini is for displaying the miniMap only, since it's purpose is for displaying only, it will not need any setter
    var regionMini: MKCoordinateRegion {
        get {
            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
        set {
            /// do nothing
        }
    }
    
    /// when modifying a place's lat and lon, the lat and lon will first be modified in the var region, then only after the editmode disappear (.onDisappear), the coordinate will be updated (which in turn kick me back to PlaceView
    var coordinate: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(latitude: placeLatitude, longitude: placeLongitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
        
    /// function to save, discardable return
    @discardableResult
    func save() -> Bool {
        do {
            try managedObjectContext?.save()
        } catch {
            print("Error saving: \(error)")
            return false
        }
        return true
    }
    
    /// function to get the image, while the image was being downloaded, display the default image instead
    /// if the image has already been downloaded (already in image library), then get the image from library in stead of re-downloading
    func getImage() async -> Image {
        // if there's no URL then return the default image
        guard let url = imageURL else { return defaultImage }
        if let image = downloadedImages[url] { return image }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let uiImg = UIImage(data: data) else { return defaultImage}
            let image = Image(uiImage: uiImg).resizable()
            downloadedImages[url] = image
            return image
        } catch {
            print("Error downloading image from URL")
        }
        return defaultImage
    }
    
//    func lookUpCoordinates(for placeName: String) {
//        let coder = CLGeocoder()
//        coder.geocodeAddressString(placeName) { optionalPlacemarks, optionalError in
//            if let error = optionalError {
//                print("Error looking up \(placeName): \(error.localizedDescription)")
//                return
//            }
//            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
//                print("Placemarks came back empty")
//                return
//            }
//            /// only get the 1st palcemark
//            let placemark = placemarks[0]
//            guard let location = placemark.location else {
//                print("Placemark has no location")
//                return
//            }
//
//            /// since coordinate only accept CLLocationCoordinate2D, and the returned location (in this func) is CLLocation, I need to convert from CLLocation to CLLocationCoordinate2D
//            let stuff = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            self.coordinate = stuff
//        }
//    }
    
    /// Function to lookup a place's name when given coordinate: CLLocationCoordinate2D
    /// - Parameter coordinate: each Place has 1 unique var coordinate
//    func lookUpName(for coordinate: CLLocationCoordinate2D) {
//        let stuff = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        
//        let coder = CLGeocoder()
//        coder.reverseGeocodeLocation(stuff) { optionalPlacemarks, optionalError in
//            if let error = optionalError {
//                print("Error looking up \(coordinate): \(error.localizedDescription)")
//                return
//            }
//            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
//                print("Placemarks came back empty")
//                return
//            }
//            let placemark = placemarks[0]
//            self.placeName = placemark.name ?? placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
//        }
//    }
    
//    func lookUpSunriseSunset() async -> SunriseSunset {
//        let urlString = "https://api.sunrise-sunset.org/json?lat=\(placeLatitude)&lng=\(placeLongitude)"
//        guard let url = URL(string: urlString) else {
//            print("Malformed URL: \(urlString)")
//            return sunriseSunset
//        }
//        guard let jsonData = try? Data(contentsOf: url) else {
//            print("Could not look up sunrise and sunset")
//            return sunriseSunset
//        }
//        guard let api = try? JSONDecoder().decode(SunriseSunsetAPI.self, from:jsonData) else {
//            print("Could not decode JSON API data")
//            return sunriseSunset
//        }
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateStyle = .none
//        inputFormatter.timeStyle = .medium
//        inputFormatter.timeZone = .init(secondsFromGMT: 0)
//
//        let outputFormatter = DateFormatter()
//        outputFormatter.dateStyle = .none
//        outputFormatter.timeStyle = .medium
//        outputFormatter.timeZone = .current
//
//        var converted = api.results
//
//        if let time = inputFormatter.date(from: api.results.sunrise) {
//            converted.sunrise = outputFormatter.string(from: time)
//        }
//        if let time = inputFormatter.date(from: api.results.sunset) {
//            converted.sunset = outputFormatter.string(from: time)
//        }
//        sunriseSunset = converted
//        return sunriseSunset
//    }
}

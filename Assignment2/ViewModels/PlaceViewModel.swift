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

extension Place {
    /// viewModel's property for "name" database attribute
    var placeName: String {
        get { name ?? "New Place" }
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
        get { latitudeText ?? 0 }
        set {
//            guard let latitudeText = Double(newValue) else {return}
            latitudeText = newValue
            save()
        }
    }

    /// viewModel's property for "longitudeText" database attribute
    var placeLongitude: Double {
        get { longitudeText ?? 0 }
        set {
            longitudeText = newValue
            save()
        }
    }
//
    var region: MKCoordinateRegion {
        get {
            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitudeText, longitude: longitudeText), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        } set {
            latitudeText = newValue.center.latitude
            longitudeText = newValue.center.longitude
            save()
        }
    }
    
    /// function to save
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
}

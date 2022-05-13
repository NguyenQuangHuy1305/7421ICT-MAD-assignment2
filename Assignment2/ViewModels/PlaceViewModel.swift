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
    var placeLocation: String {
        get { location ?? "Input the location here" }
        set {
            location = newValue
            save()
        }
    }
    var placeNote: String {
        get { note ?? "Input your note here"}
        set {
            note = newValue
            save()
        }
    }
    var urlString: String{
        get { imageURL?.absoluteString ?? "Input your URL here"}
        set {
            guard let url = URL(string: newValue) else { return }
            imageURL = url
            save()
        }
    }
    var placeLatitude: Double{
        get { latitude ?? 0}
        set {
            latitude = newValue
            save()
        }
    }
    var placeLongitude: Double{
        get { longitude ?? 0}
        set {
            longitude = newValue
            save()
        }
    }
    
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

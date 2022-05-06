//
//  PlaceViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import CoreData
import SwiftUI

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
        get { location ?? "" }
        set {
            location = newValue
            save()
        }
    }
    var placeNote: String {
        get { note ?? ""}
        set {
            note = newValue
            save()
        }
    }
    var urlString: String{
        get { imageURL?.absoluteString ?? ""}
        set {
            guard let url = URL(string: newValue) else { return }
            imageURL = url
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

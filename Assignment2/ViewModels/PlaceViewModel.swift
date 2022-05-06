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
var currentlyDownloading = Set<URL>()

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
    
    func getImage() -> Image {
        // if there's no URL then return the default image
        guard let url = imageURL else { return defaultImage }
        if let image = downloadedImages[url] { return image }
        if currentlyDownloading.contains(url) { return defaultImage }
        currentlyDownloading.insert(url)
        
        DispatchQueue.global(qos: .userInteractive).async {
            /// try to get the data from URL, then try to convert it into UIImage, else just return nothing
            guard let data = try? Data(contentsOf: url),
                  let uiImg = UIImage(data: data) else {return}
            let image = Image(uiImage: uiImg).resizable()
            DispatchQueue.main.async {
                downloadedImages[url] = image
                currentlyDownloading.remove(url)
                self.objectWillChange.send()
            }
        }
        return defaultImage
    }
}

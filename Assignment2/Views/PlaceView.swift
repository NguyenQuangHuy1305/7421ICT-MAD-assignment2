//
//  PlaceView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import SwiftUI

let defaultImage = Image(systemName: "photo")

struct PlaceView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    
    var body: some View {
        List {
            if editMode?.wrappedValue == .active {
                TextField("Enter place's name", text: $place.placeName)
                TextField("Enter place's location", text: $place.placeLocation)
                TextField("Enter place's note", text: $place.placeNote)
                TextField("Enter place's image URL", text: $place.urlString)
            } else {
                Text(place.placeLocation)
                Text(place.placeNote)
                image(for: place.imageURL).aspectRatio(contentMode: .fit)
            }
        }.navigationTitle(place.placeName)
    }
    
    func image(for url: URL?) -> Image {
        guard let url = url,
              let data = try? Data(contentsOf: url),
              let uiImg = UIImage(data: data) else {return defaultImage}
        return Image(uiImage: uiImg).resizable()
    }
}

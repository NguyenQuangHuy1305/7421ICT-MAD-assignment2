//
//  PlaceRowView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import SwiftUI

struct PlaceRowView: View {
    @ObservedObject var place: Place
    @State var image = Image(systemName: "photo")

    var body: some View {
        HStack {
            image.frame(width: 30, height: 20)
            Text(place.placeName)
            .task {
                /// wait for the place.getImage() function before actually displaying the image
                image = await place.getImage()
            }
        }
    }
}

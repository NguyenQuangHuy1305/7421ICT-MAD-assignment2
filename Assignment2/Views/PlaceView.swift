//
//  PlaceView.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import SwiftUI

struct PlaceView: View {
    @ObservedObject var place: Place
    
    var body: some View {
        List {
            Text(place.placeLocation)
            Text(place.placeNote)
            if let url = place.imageURL {
                Text("URL: \(url.absoluteString)")
            }
        }
    }
}

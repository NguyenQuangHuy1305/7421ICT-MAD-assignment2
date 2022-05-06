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
    
    var body: some View {
        Text(place.placeName)
    }
}

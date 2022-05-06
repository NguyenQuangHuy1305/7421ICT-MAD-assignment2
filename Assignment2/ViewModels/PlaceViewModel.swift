//
//  PlaceViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 4/5/2022.
//

import Foundation
import CoreData
import SwiftUI

extension Place {
    /// viewModel's property for "name" database attribute
    var placeName: String {
        get { name ?? "<unknown>" }
        set { name = newValue }
    }
    var placeLocation: String {
        get { location ?? "" }
        set { location = newValue }
    }
    var placeNote: String {
        get { note ?? ""}
        set { note = newValue }
    }
}

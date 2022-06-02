////
////  PlaceViewModel1.swift
////  Assignment2
////
////  Created by Nguyen Quang Huy on 2/6/2022.
////
//
//import Foundation
//import CoreData
//import SwiftUI
//import MapKit
//
//class PlaceViewModel1: ObservableObject {
//
//    private let place: Place
//
//    var latitude: Double {
//        get {
//            place.latitude
//        } set {
//            place.latitude = newValue
//            //objectWillChange.send()
//        }
//    }
//
//    var longitude: Double {
//        get {
//            place.longitude
//        } set {
//            place.longitude = newValue
//            //objectWillChange.send()
//        }
//    }
//
//    init(place: Place) {
//        self.place = place
//    }
//
//
//    func save() {
//        objectWillChange.send()
//    }
//
//}

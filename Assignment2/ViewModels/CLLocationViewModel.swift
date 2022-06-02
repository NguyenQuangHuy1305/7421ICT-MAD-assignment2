////
////  CLLocationViewModel.swift
////  Assignment2
////
////  Created by Nguyen Quang Huy on 1/6/2022.
////
//
//import Foundation
//import Combine
//import CoreLocation
//
//class LocationViewModel: ObservableObject {
//    @Published var location: CLLocation
//    @Published var name = ""
//    
//    init(location: CLLocation) {
//        self.location = location
//    }
//    
//    var latitudeString: String {
//        get { "\(location.coordinate.latitude)" }
//        set {
//            guard let coord = Double(newValue) else { return }
//            coordinate.latitude = coord
//        }
//    }
//}

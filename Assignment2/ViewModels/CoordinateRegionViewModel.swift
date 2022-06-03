//
//  CoordinateRegionViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 12/5/2022.
//

import Foundation
import MapKit
import CoreLocation
import Combine

/// this is the extension for the MKCoordinateRegion, used in MapView to display region.latitudeString
extension MKCoordinateRegion {
    
    /// this is for equatable protocol
//    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
//        lhs.center.latitude == rhs.center.latitude &&
//        lhs.center.longitude == rhs.center.latitude
//    }
    
    /// when a newValue was assigned to center.latitude, transform newValue into CLLocationDegrees then assign it to center.latitude
    /// also the abs value of lat cannot be 90 or more
    var latitudeString: String {
        get { "\(center.latitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue), abs(degrees) <= 90 else { return }
            center.latitude = degrees
        }
    }
    
    /// when a newValue was assigned to center.longitude, transform newValue into CLLocationDegrees then assign it to center.longitude
    /// also abs value of lon cannot be 180 or more
    var longitudeString: String {
        get { "\(center.longitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue), abs(degrees) <= 180 else { return }
            center.longitude = degrees
        }
    }
}

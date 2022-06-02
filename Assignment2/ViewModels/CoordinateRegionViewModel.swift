//
//  CoordinateRegionViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 12/5/2022.
//

import Foundation
import MapKit
import CoreLocation

/// this is the extension for the MKCoordinateRegion, used in MapView to display region.latitudeString
extension MKCoordinateRegion {    
    /// when a newValue was assigned to center.latitude, transform newValue into CLLocationDegrees then assign it to center.latitude
    var latitudeString: String {
        get { "\(center.latitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.latitude = degrees
        }
    }
    
    /// when a newValue was assigned to center.longitude, transform newValue into CLLocationDegrees then assign it to center.longitude
    var longitudeString: String {
        get { "\(center.longitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            center.longitude = degrees
        }
    }
}

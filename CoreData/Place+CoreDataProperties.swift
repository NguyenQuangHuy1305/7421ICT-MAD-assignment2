//
//  Place+CoreDataProperties.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 6/5/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var note: String?
    @NSManaged public var imageURL: URL?
    @NSManaged public var latitudeText: Double?
    @NSManaged public var longitudeText: Double?

}

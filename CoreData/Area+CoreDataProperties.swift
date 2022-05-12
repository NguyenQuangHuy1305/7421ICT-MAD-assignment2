//
//  Area+CoreDataProperties.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 12/5/2022.
//
//

import Foundation
import CoreData


extension Area {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }

    @NSManaged public var areaName: String?

}

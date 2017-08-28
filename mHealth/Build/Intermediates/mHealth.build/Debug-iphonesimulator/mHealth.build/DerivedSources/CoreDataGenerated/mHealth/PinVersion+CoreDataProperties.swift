//
//  PinVersion+CoreDataProperties.swift
//  
//
//  Created by Abe Rodriguez on 6/20/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension PinVersion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PinVersion> {
        return NSFetchRequest<PinVersion>(entityName: "PinVersion")
    }

    @NSManaged public var pin: String?
    @NSManaged public var version: Int16

}

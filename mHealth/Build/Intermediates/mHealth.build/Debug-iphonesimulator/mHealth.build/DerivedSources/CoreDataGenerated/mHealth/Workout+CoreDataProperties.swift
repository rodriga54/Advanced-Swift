//
//  Workout+CoreDataProperties.swift
//  
//
//  Created by Abe Rodriguez on 6/20/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var workoutDate: NSDate?
    @NSManaged public var workoutInstruction: String?
    @NSManaged public var workoutKey: String?
    @NSManaged public var workoutLabel: String?
    @NSManaged public var workoutTime: String?

}

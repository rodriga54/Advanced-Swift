//
//  Exercise+CoreDataProperties.swift
//  
//
//  Created by Abe Rodriguez on 6/20/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var exerciseCat: String?
    @NSManaged public var exerciseDate: NSDate?
    @NSManaged public var exerciseKey: String?
    @NSManaged public var exerciseName: String?
    @NSManaged public var exerciseTime: String?

}

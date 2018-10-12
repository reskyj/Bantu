//
//  Needs+CoreDataProperties.swift
//  
//
//  Created by Steven Muliamin on 12/10/18.
//
//

import Foundation
import CoreData


extension Needs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Needs> {
        return NSFetchRequest<Needs>(entityName: "Needs")
    }

    @NSManaged public var needsId: Int64
    @NSManaged public var needsName: String?

}

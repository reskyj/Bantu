//
//  SeenPost+CoreDataProperties.swift
//  
//
//  Created by Gior Fasolini on 11/10/18.
//
//

import Foundation
import CoreData


extension SeenPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SeenPost> {
        return NSFetchRequest<SeenPost>(entityName: "SeenPost")
    }

    @NSManaged public var postUUID: String?

}

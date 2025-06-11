//
//  CDFlag+CoreDataProperties.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//
//

import Foundation
import CoreData


extension CDFlag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFlag> {
        return NSFetchRequest<CDFlag>(entityName: "CDFlag")
    }

    @NSManaged public var png: String?
    @NSManaged public var svg: String?
    @NSManaged public var toCountry: CDCountry?

}

extension CDFlag : Identifiable {

}

//
//  CDCountry+CoreDataProperties.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//
//

import Foundation
import CoreData


extension CDCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCountry> {
        return NSFetchRequest<CDCountry>(entityName: "CDCountry")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var capital: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var currencies: CDCurrency?
    @NSManaged public var flags: CDFlag?

}

extension CDCountry : Identifiable {

}

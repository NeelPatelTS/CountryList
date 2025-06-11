//
//  CDCurrency+CoreDataProperties.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//
//

import Foundation
import CoreData


extension CDCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCurrency> {
        return NSFetchRequest<CDCurrency>(entityName: "CDCurrency")
    }

    @NSManaged public var currencyName: String?
    @NSManaged public var code: String?
    @NSManaged public var symbol: String?
    @NSManaged public var toCountry: CDCountry?

}

extension CDCurrency : Identifiable {

}

extension CDCurrency {
    func toCurrency() -> Currency {
        return Currency(
            code: self.code,
            name: self.currencyName,
            symbol: self.symbol
        )
    }
}

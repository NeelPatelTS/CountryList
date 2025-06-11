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
    @NSManaged public var currencies: NSSet?
    @NSManaged public var flags: CDFlag?

}

extension CDCountry {
    @objc(addCurrenciesObject:)
    @NSManaged public func addToCurrencies(_ value: CDCurrency)

    @objc(removeCurrenciesObject:)
    @NSManaged public func removeFromCurrencies(_ value: CDCurrency)

    @objc(addCurrencies:)
    @NSManaged public func addToCurrencies(_ values: NSSet)

    @objc(removeCurrencies:)
    @NSManaged public func removeFromCurrencies(_ values: NSSet)

}

extension CDCountry : Identifiable {

}

extension CDCountry {
    func toCountry() -> Country {
        return Country(name: self.name ?? "",
                       capital: self.capital,
                       flags: self.flags?.toFlags(),
                       currencies: (self.currenciesArray.map { $0.toCurrency() }))
    }

    var currenciesArray: [CDCurrency] {
        let set = self.currencies as? Set<CDCurrency> ?? []
        return Array(set)
    }
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
extension CDFlag {
    func toFlags() -> Flag {
        return Flag(
            svg: self.svg,
            png: self.png
        )
    }
}

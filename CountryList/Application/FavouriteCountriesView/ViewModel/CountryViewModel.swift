//
//  CountryViewModel.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import Foundation
import CoreData

@MainActor
class CountryListViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var allCountries: [Country] = []
    @Published var favcountries: [Country] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let context: NSManagedObjectContext
    private let apiService: APIServiceProtocol

    // MARK: - Init
    init(apiService: APIServiceProtocol = APIService(),context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.apiService = apiService
        self.context = context
    }

    // MARK: - API Fetch
    func fetchCountries() async {
        isLoading = true
        errorMessage = nil
        do {
            let countries = try await apiService.fetchCountries()
            saveOrUpdateCountries(countries)
        } catch let error as APIError {
            errorMessage = error.description
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    // MARK: - Core Data Fetch

    /// Fetch all countries from Core Data and sort by name A-Z
    func getAllCountries() {
        let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        if let results = try? context.fetch(fetchRequest) {
            allCountries = results.map { $0.toCountry() }
        }
    }
    
    /// Set a default country as favorite if it matches the given name
    func setDefaultFirstCountries(name: String) {
        let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        if !name.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name ==[c] %@", name)
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            if let cdCountry = results.first {
                cdCountry.isFavourite = true
                saveContext()
                getFavCountries()
            }
        } catch {
            print("Fetch error: \(error)")
            allCountries = []
        }
    }

    /// Fetch only favorite countries
    func getFavCountries(){
        let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavourite == true")
        
        if let results = try? context.fetch(fetchRequest) {
            favcountries = results.map { $0.toCountry() }
        }
    }
    
    /// Toggle favorite status for a given country
    func toggleFavorite(for country: Country) {
        let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", country.id)

        do {
            let results = try context.fetch(fetchRequest)
            if let cdCountry = results.first {
                cdCountry.isFavourite.toggle()
                saveContext()
                getFavCountries()
            }
        } catch {
            print("❌ Failed to toggle favorite: \(error.localizedDescription)")
        }
    }
    
    /// Check if a country is already marked as favorite
    func isAlreadyFavourite(_ country: Country) -> Bool {
        favcountries.contains(where: { $0.id == country.id })
    }
    
    // MARK: - Core Data Save or Update
    
    /// Check if a country is already marked as favorite
    private func saveOrUpdateCountries(_ countries: [Country]) {
        for country in countries {
            // Check if record with same ID already exists
            let fetchRequest: NSFetchRequest<CDCountry> = CDCountry.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", country.id)

            if let results = try? context.fetch(fetchRequest), let existingCountry = results.first {
                existingCountry.name = country.name
                existingCountry.capital = country.capital
                merge(country.flags, into: existingCountry)
                merge(country.currencies, into: existingCountry)
            } else {
                let newCountry = CDCountry(context: context)
                newCountry.id = country.id
                newCountry.name = country.name
                newCountry.capital = country.capital
                newCountry.isFavourite = false
                merge(country.flags, into: newCountry)
                merge(country.currencies, into: newCountry)
            }
        }
        saveContext()
    }
    
    // MARK: - Core Data Merge Helpers

        /// Merge flag data into CDCountry
    private func merge(_ flags: Flag?, into country: CDCountry) {
        guard let flags = flags else { return }
        let cdFlags = country.flags ?? CDFlag(context: country.managedObjectContext!)
        cdFlags.png = flags.png
        cdFlags.svg = flags.svg
        country.flags = cdFlags
    }

    /// Merge currency data into CDCountry
    private func merge(_ currencies: [Currency]?, into country: CDCountry) {
        // Remove existing currencies
        if let existing = country.currencies as? Set<CDCurrency> {
            for currency in existing {
                context.delete(currency)
            }
        }

        // Add new currencies
        currencies?.forEach { cur in
            let cd = CDCurrency(context: context)
            cd.code = cur.code
            cd.currencyName = cur.name
            cd.symbol = cur.symbol
            country.addToCurrencies(cd)
        }
    }
    
    // MARK: - Core Data Save

    /// Save context changes
    private func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("CoreData save error:", error)
        }
    }
}

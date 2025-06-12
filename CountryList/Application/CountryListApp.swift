//
//  CountryListApp.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import SwiftUI

@main
struct CountryListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FavouriteCountriesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

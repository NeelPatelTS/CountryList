//
//  Persistence.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import CoreData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init(useInMemoryStore: Bool = false) {
        let modelName = "CountryList"
        container = NSPersistentContainer(name: modelName)

        if useInMemoryStore {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Failed to load store: \(storeDescription)")
                fatalError("Core Data error: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}


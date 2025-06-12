//
//  Persistence.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    /// In-memory store for previews/tests
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Example preview data
        let previewDogs: [Dog] = [
            Dog(name: "Chief", description: "Leader of a pack", age: 5, image: "https://example.com/chief.jpg"),
            Dog(name: "Spots", description: "Guard dog for Mayor", age: 4, image: "https://example.com/spots.jpg")
        ]

        for dog in previewDogs {
            let entity = DoggoEntity(context: viewContext)
            entity.doggoName = dog.name
            entity.description_ = dog.description
            entity.age = Int16(dog.age)
            entity.image = dog.image
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("❌ Preview store error: \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    /// Shortcut for easier context access
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DoggoGallery")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("❌ Core Data failed to load: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

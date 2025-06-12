//
//  DoggoPersistenceService.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Foundation
import CoreData

protocol DogStoring {
    func saveDogs(_ dogs: [Dog])
    func loadDogs() -> [Dog]
}

final class DoggoPersistenceService: DogStoring {
    private let context: NSManagedObjectContext

    /// Standard app initializer (uses real Core Data)
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    /// In-memory static initializer (for previews/tests)
    static func inMemory() -> DoggoPersistenceService {
        let previewController = PersistenceController(inMemory: true)
        return DoggoPersistenceService(context: previewController.container.viewContext)
    }

    func saveDogs(_ dogs: [Dog]) {
        clearExistingDogs()

        for dog in dogs {
            let entity = DoggoEntity(context: context)
            entity.doggoName = dog.name
            entity.description_ = dog.description
            entity.age = Int16(dog.age)
            entity.image = dog.image
        }

        do {
            try context.save()
        } catch {
            print("❌ Failed to save dogs: \(error.localizedDescription)")
        }
    }

    func loadDogs() -> [Dog] {
        let request: NSFetchRequest<DoggoEntity> = DoggoEntity.fetchRequest()

        do {
            let results = try context.fetch(request)
            return results.compactMap { entity in
                if let name = entity.doggoName,
                   let desc = entity.description_,
                   let img = entity.image {
                    return Dog(name: name, description: desc, age: Int(entity.age), image: img)
                } else {
                    return nil
                }
            }
        } catch {
            print("❌ Failed to load dogs: \(error.localizedDescription)")
            return []
        }
    }

    private func clearExistingDogs() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DoggoEntity")
        let delete = NSBatchDeleteRequest(fetchRequest: fetch)
        _ = try? context.execute(delete)
    }
}

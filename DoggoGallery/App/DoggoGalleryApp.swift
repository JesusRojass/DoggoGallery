//
//  DoggoGalleryApp.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import SwiftUI

@main
struct DoggoGalleryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DoggoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  DoggoListViewModel.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Foundation
import Combine

@MainActor
final class DoggoListViewModel: ObservableObject {
    @Published var dogs: [Dog] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    private let dogFetcher: DogFetching
    private let dogStore: DogStoring
    private var cancellables = Set<AnyCancellable>()

    init(
        dogFetcher: DogFetching = DogAPIService(),
        dogStore: DogStoring = DoggoPersistenceService()
    ) {
        self.dogFetcher = dogFetcher
        self.dogStore = dogStore
        loadData()
    }

    /// Determines whether to fetch from API or Core Data
    func loadData() {
        if UserDefaults.standard.bool(forKey: "HasLoadedDogs") {
            print("📦 Loading from Core Data")
            self.dogs = dogStore.loadDogs()
        } else {
            fetchDogs()
        }
    }
    
    @MainActor
    func refreshData() async {
        resetCache()
        fetchDogs()
    }

    /// Fetches from API and stores in Core Data
    func fetchDogs() {
        isLoading = true

        dogFetcher.fetchDogs()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.error = error.localizedDescription
                    print("❌ API Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] dogs in
                self?.dogs = dogs
                self?.dogStore.saveDogs(dogs)
                UserDefaults.standard.set(true, forKey: "HasLoadedDogs")
                print("✅ Dogs fetched from API and saved to Core Data")
            })
            .store(in: &cancellables)
    }
    
    /// Clears cache from API
    func resetCache() {
        UserDefaults.standard.set(false, forKey: "HasLoadedDogs")
        self.dogs = []
    }
}

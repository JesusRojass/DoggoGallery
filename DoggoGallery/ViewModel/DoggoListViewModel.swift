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
    private var cancellables = Set<AnyCancellable>()

    init(dogFetcher: DogFetching = DogAPIService()) {
        self.dogFetcher = dogFetcher
        fetchDogs()
    }

    func fetchDogs() {
        isLoading = true
        dogFetcher.fetchDogs()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(err) = completion {
                    self?.error = err.localizedDescription
                }
            }, receiveValue: { [weak self] dogs in
                self?.dogs = dogs
            })
            .store(in: &cancellables)
    }
}

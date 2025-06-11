//
//  DogAPIService.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Foundation
import Combine

final class DogAPIService: DogFetching {
    private let url = URL(string: "https://jsonblob.com/api/1151549092634943488")!

    func fetchDogs() -> AnyPublisher<[Dog], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                if let raw = String(data: data, encoding: .utf8) {
                    print("📦 Raw JSON:\n\(raw)")
                }
                return data
            }
            .decode(type: [Dog].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

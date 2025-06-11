//
//  APIClient.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Foundation
import Combine

final class APIClient {
    static let shared = APIClient()
    private init() {}

    func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

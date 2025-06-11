//
//  DoggoFetching.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Combine

protocol DogFetching {
    func fetchDogs() -> AnyPublisher<[Dog], Error>
}

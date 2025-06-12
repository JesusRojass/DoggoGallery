//
//  DoggoStoring.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Combine

protocol DoggoStoring {
    func fetchDogs() -> [Dog]
    func saveDogs(_ dogs: [Dog])
    func clearDogs()
}

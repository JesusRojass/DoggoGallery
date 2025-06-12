//
//  DoggoDetailViewModel.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Foundation

final class DoggoDetailViewModel: ObservableObject {
    let dog: Dog

    init(dog: Dog) {
        self.dog = dog
    }
}

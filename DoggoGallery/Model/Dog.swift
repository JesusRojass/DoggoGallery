//
//  Dog.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import Foundation

struct Dog: Codable, Identifiable {
    let name: String
    let description: String
    let age: Int
    let image: String

    var id: String {
        "\(name)-\(age)"
    }

    enum CodingKeys: String, CodingKey {
        case name = "dogName"
        case description
        case age
        case image
    }
}

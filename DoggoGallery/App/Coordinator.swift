//
//  Coordinator.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import SwiftUI

final class Coordinator {

    func makeDoggoDetailView(for dog: Dog) -> some View {
        let viewModel = DoggoDetailViewModel(dog: dog)
        return DoggoDetailView(viewModel: viewModel)
    }
}

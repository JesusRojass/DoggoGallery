//
//  DoggoDetailView.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import SwiftUI

struct DoggoDetailView: View {
    @ObservedObject var viewModel: DoggoDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: viewModel.dog.image)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.gray.opacity(0.1)
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, minHeight: 300)
                        .cornerRadius(12)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, minHeight: 300)
                            .foregroundColor(.gray)
                            .cornerRadius(12)
                    @unknown default:
                        EmptyView()
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.dog.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)

                    Text("Almost \(viewModel.dog.age) years old")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text(viewModel.dog.description)
                        .font(.body)
                        .foregroundColor(.secondaryText)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .background(Color("AppBackground").ignoresSafeArea())
        .navigationTitle(viewModel.dog.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

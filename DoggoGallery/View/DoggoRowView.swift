//
//  DoggoRowView.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import SwiftUI

struct DoggoRowView: View {
    let dog: Dog

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: URL(string: dog.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 80, height: 100)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(dog.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primaryText)

                Text(dog.description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondaryText)
                    .lineLimit(3)

                Text("Almost \(dog.age) years")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primaryText)
                    .padding(.top, 2)
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

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
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: dog.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 120)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 120)
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
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                    .frame(height: 52, alignment: .top)

                Spacer()

                Text("Almost \(dog.age) years")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .layoutPriority(1)
        }
        .padding()
        .frame(height: 160) // ❗ Fixed height card — no more jumpy layout
        .background(Color.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}

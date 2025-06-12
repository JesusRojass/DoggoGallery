//
//  DoggoListView.swift
//  DoggoGallery
//
//  Created by Jesus Rojas on 11/06/25.
//

import SwiftUI
import CoreData

struct DoggoListView: View {
    @StateObject private var viewModel = DoggoListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView("Fetching doggos…")
                            .padding()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(viewModel.dogs) { dog in
                            DoggoRowView(dog: dog)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .background(Color.appBackground)
            .navigationTitle("Dogs We Love")
            .refreshable {
                await viewModel.refreshData()
            }
        }
    }
}

#Preview {
    DoggoListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

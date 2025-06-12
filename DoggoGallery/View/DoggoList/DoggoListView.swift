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
    @State private var coordinator = Coordinator()

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
                            NavigationLink(destination: coordinator.makeDoggoDetailView(for: dog)) {
                                DoggoRowView(dog: dog)
                            }
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

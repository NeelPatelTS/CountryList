//
//  FavouriteCountriesView.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import SwiftUI

struct FavouriteCountriesView: View {
    
    @State private var path: [Route] = []
    @StateObject private var viewModel = CountryListViewModel()
    @State private var showError = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List(viewModel.favcountries, id: \.self) { country in
                    Button {
                        path.append(.details(country))
                    } label: {
                        HStack {
                            FavouriteCountrieCardCell(country: country)
                            Button(action: {
                                viewModel.toggleFavorite(for: country)
                            }) {
                                Image(systemName: "minus.circle.fill" )
                                    .foregroundColor(.red)
                            }
                        }
                        
                    }
                }
                .listStyle(.plain)
                Spacer()
                searchButtonView
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .details(let country):
                    DetailsView(country: country)
                case .search:
                    CountrySearchView(viewModel: viewModel, path: $path)
                }
            }
            .navigationTitle(Strings.NavigationTitle.favourite)
            .onAppear {
                Task {
                    await viewModel.fetchCountries()
                    viewModel.getAllCountries()
                    viewModel.getFavCountries()
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.favcountries.count == 0 {
                    Color.black.opacity(0.25).ignoresSafeArea()
                    ProgressView(Strings.Placeholder.loading)
                }
            }
            .onReceive(viewModel.$errorMessage) { message in
                // If message is not nil, show the alert
                showError = message != nil
            }
            .alert("Error", isPresented: $showError, actions: {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil  // clear after dismiss
                }
            }, message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            })
        }
    }
    
    private var searchButtonView: some View {
        Button {
            path.append(.search)
        } label: {
            HStack {
                Text("Add")
                    .font(.system(size: 18, weight: .medium))
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .foregroundColor(.white)
            .background(Color.black.cornerRadius(5))
            .padding(.horizontal,20)
        }
        .buttonStyle(.plain)
    }
}


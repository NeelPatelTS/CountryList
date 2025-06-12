//
//  FavouriteCountriesView.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import SwiftUI

struct FavouriteCountriesView: View {

    // MARK: - State
    @StateObject private var locationManager = LocationManager()
    @State private var path: [Route] = []
    @StateObject private var viewModel = CountryListViewModel()
    @State private var showError = false
    
    // MARK: - View
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if viewModel.favcountries.isEmpty && !viewModel.isLoading {
                    EmptyStateView()
                } else {
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
                }
                addButtonView
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
            .onFirstAppear {
                Task {
                    await viewModel.fetchCountries()
                    viewModel.getAllCountries()
                    viewModel.getFavCountries()
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.favcountries.count == 0 {
                    //Color.black.opacity(0.50).ignoresSafeArea()
                    ProgressView {
                        HStack{
                            Image(systemName: "hand.raised")
                            Text(Strings.Placeholder.loading)
                        }
                    }.controlSize(.extraLarge)
                }
            }
            .onReceive(viewModel.$errorMessage) { message in
                showError = message != nil
            }
            .onReceive(locationManager.$country.compactMap { $0 }) { country in
                viewModel.setDefaultFirstCountries(name: country)
            }
            .onReceive(locationManager.$authorizationStatus) { status in
                if status == .denied {
                    viewModel.setDefaultFirstCountries(name: "")
                }
            }
            .alert(Strings.alertTitle.error, isPresented: $showError, actions: {
                Button(Strings.ButtonTitle.ok, role: .cancel) {
                    viewModel.errorMessage = nil
                }
            }, message: {
                Text(viewModel.errorMessage ?? APIError.unowned.description)
            })
        }
    }
    
    // MARK: - Add Button View
    private var addButtonView: some View {
        Button {
            path.append(.search)
        } label: {
            HStack {
                Image(systemName: "plus")
                    .foregroundStyle(Color(UIColor.white))
                Text(Strings.ButtonTitle.add)
                    .foregroundStyle(Color(UIColor.white))
                    .font(.system(size: 18, weight: .medium))
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color(uiColor: .systemIndigo)
                .cornerRadius(5))
            .padding(.horizontal,20)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Empty State View
    struct EmptyStateView: View {

        var body: some View {
            VStack {
                Spacer()
                Text(Strings.Placeholder.noDataFound)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
}


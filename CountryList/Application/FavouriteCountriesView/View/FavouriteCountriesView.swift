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
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List(viewModel.countries, id: \.self) { country in
                    Button {
                        path.append(.details(country))
                    } label: {
                        FavouriteCountrieCardCell(country: country)
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
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.countries.count == 0 {
                    Color.black.opacity(0.25).ignoresSafeArea()
                    ProgressView(Strings.Placeholder.loading)
                }
            }
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
        .disabled(viewModel.countries.isEmpty)
    }
}


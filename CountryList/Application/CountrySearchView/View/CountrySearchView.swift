//
//  CountrySearchView.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

struct CountrySearchView: View {
    
    // MARK: - Environment & State
    @State private var searchText = ""
    @ObservedObject var viewModel: CountryListViewModel
    @Binding var path: [Route]
    @State private var showLimitAlert = false
    private let countryAddLimit = 5
    
    // MARK: - Filtered Search Results
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.allCountries
        } else {
            return viewModel.allCountries
                .filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
        }
    }
    
    // MARK: - View Body
    var body: some View {
        List(filteredCountries) { country in
            Button {
                path.append(.details(country))
            } label: {
                HStack {
                    let isFavourite = viewModel.isAlreadyFavourite(country)
                    FavouriteCountrieCardCell(country: country)
                    Button(action: {
                        if !isFavourite && viewModel.favcountries.count >= countryAddLimit {
                            showLimitAlert.toggle()
                        }else {
                            viewModel.toggleFavorite(for: country)
                        }
                    }) {
                        Image(
                            systemName: isFavourite ? "minus.circle.fill" : "plus.circle.fill"
                        )
                        .foregroundColor(
                            isFavourite ? .red : Color(UIColor.label)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(Strings.NavigationTitle.countries)
        .searchable(text: $searchText, prompt: Strings.Placeholder.search)
         // MARK: - Limit Alert
        .alert(Strings.alertTitle.selectionLimit, isPresented: $showLimitAlert) {
            Button(Strings.ButtonTitle.ok, role: .cancel) {
                showLimitAlert.toggle()
            }
        } message: {
            Text(Strings.alertMessage.limtExceeded)
        }
    }
}

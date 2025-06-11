//
//  CountrySearchView.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

struct CountrySearchView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @ObservedObject var viewModel: CountryListViewModel
    @Binding var path: [Route]
    
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.allCountries
        } else {
            return viewModel.allCountries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        List(filteredCountries) { country in
            Button {
                path.append(.details(country))
            } label: {
                HStack {
                    FavouriteCountrieCardCell(country: country)
                    Button(action: {
                        viewModel.toggleFavorite(for: country)
                    }) {
                        let isFavourite = viewModel.isAlreadyFavourite(country)
                        Image(systemName: isFavourite ? "minus.circle.fill" : "plus.circle.fill")
                            .foregroundColor(isFavourite ? .red : .black)
                    }
                }
                
            }
        }.listStyle(.plain)
            .navigationTitle("Countries")
            .searchable(text: $searchText, prompt: "Search Countries")
    }
}

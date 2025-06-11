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
            return viewModel.countries
        } else {
            return viewModel.countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        List(filteredCountries) { country in
            
            Button {
                path.append(.details(country))
            } label: {
                CountrieCardCell(country: country)
            }
        }.listStyle(.plain)
            .navigationTitle("Countries")
            .searchable(text: $searchText, prompt: "Search Countries")
    }
}

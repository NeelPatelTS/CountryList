//
//  FavouriteCountriesView.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import SwiftUI

struct FavouriteCountriesView: View {
        
    @State private var path: [Country] = []
    
    // Sample data
    let countries: [Country] = [
            Country(id: "1", name: "India", capital: "New Delhi", currencies: [Currency(code: "INR", name: "Rupee", symbol: "₹")], flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_the_Taliban.svg/320px-Flag_of_the_Taliban.svg.png"),
            Country(id: "2", name: "USA", capital: "Washington, D.C.", currencies: [Currency(code: "USD", name: "Dollar", symbol: "$")], flag: nil),
            Country(id: "3", name: "Japan", capital: "Tokyo", currencies: [Currency(code: "JPY", name: "Yen", symbol: "¥")], flag: nil)
        ]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List(countries, id: \.self) { country in
                    // Step 2: Navigate on tap
                    Button {
                        path.append(country)
                    } label: {
                        FavouriteCountrieCardCell(country: country)
                    }
                }
                .listStyle(.plain)
                Spacer()
                searchButtonView
            }
            .navigationDestination(for: Country.self) { country in
                DetailsView(country: country)
            }
            .navigationTitle("Favourite Countries")
        }
    }
    
    private var searchButtonView: some View {
        Button {
           // path.append("search")
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
        //.disabled(viewModel.allCountries.isEmpty)
    }
}

#Preview {
    FavouriteCountriesView()
}

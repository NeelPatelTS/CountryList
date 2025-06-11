//
//  DetailsView.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

struct DetailsView: View {
    
    // MARK: - Properties
    let country: Country
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                FlagImageView(imageString: country.flags?.png ?? "")
                    .frame(maxWidth: .infinity,maxHeight: 200)
                Text(Strings.Title.country(country.name))
                Text(Strings.Title.capital(country.capital))
                Text(Strings.Title.currencyName(country.currencies?.first?.name))
                Text(Strings.Title.symbol(country.currencies?.first?.symbol))
                Spacer()
            }
            .padding()
            .navigationTitle("Country Details").lineLimit(0)
        }
        
    }
}

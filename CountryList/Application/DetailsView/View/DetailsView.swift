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
                    .padding(.bottom,30)
                Text(Strings.TextTitle.country).bold() + Text(country.name)
                Text(Strings.TextTitle.capital).bold() + Text(country.capital ?? " - ")
                Text(Strings.TextTitle.currencyName).bold() + Text(country.currencies?.first?.name ?? " - ")
                Text(Strings.TextTitle.symbol).bold() + Text(country.currencies?.first?.symbol ?? " - ")
                Spacer()
            }
            .padding()
            .navigationTitle("Country Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

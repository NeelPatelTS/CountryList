//
//  DetailsView.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

struct DetailsView: View {
    let country: Country
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                FlagImageView(imageString: country.flag).frame(width: 100,height: 100)
                Text("Country: \(country.name)").font(.title)
                if let capital = country.capital {
                    Text("Capital: \(capital)")
                }
                if let currency = country.currencies?.first {
                    Text("Currency: \(currency.name ?? "") (\(currency.symbol ?? ""))")
                }
            }
            .padding()
            .navigationTitle(country.name)
        }
}

#Preview {
    DetailsView(country: Country(id: "1", name: "India", capital: "New Delhi", currencies: [Currency(code: "INR", name: "Rupee", symbol: "₹")], flag: nil))
}

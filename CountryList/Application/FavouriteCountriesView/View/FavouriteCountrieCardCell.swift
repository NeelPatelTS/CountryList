//
//  FavouriteCountrieCardCell.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import SwiftUI

struct FavouriteCountrieCardCell: View {
    let country: Country
    var body: some View {
        HStack {
            FlagImageView(imageString: country.flags?.png ?? "")
                .frame(width: 80,height: 40)
            Text(country.name)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

//
//  CountrieCardCell.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

struct CountrieCardCell: View {
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
            Button(action: {
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.black)
            }
        }
    }
}

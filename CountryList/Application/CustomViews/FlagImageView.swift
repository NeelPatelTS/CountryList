//
//  FlagImageView.swift
//  CountryList
//
//  Created by Neel on 10/06/25.
//

import SwiftUI

struct FlagImageView: View {
    
    // MARK: - Properties
    let imageString: String?

    // MARK: - Body
    var body: some View {
        if let urlString = imageString,
           let url = URL(string: urlString) {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                default:
                    Image(systemName: "photo.badge.exclamationmark.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
        } else {
            Image(systemName: "photo.badge.exclamationmark.fill")
                .resizable()
                .scaledToFit()
        }
    }
}

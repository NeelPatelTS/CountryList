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
            }.shadow(color: .black.opacity(0.5), radius: 5, x: 3, y: 3)
        } else {
            Image(systemName: "photo.badge.exclamationmark.fill")
                .resizable()
                .scaledToFit()
        }
    }
}

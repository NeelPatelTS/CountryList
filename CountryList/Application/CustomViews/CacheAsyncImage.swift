//
//  CacheAsyncImage.swift
//  CountryList
//
//  Created by Neel on 11/06/25.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    
    // MARK: - Properties
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(url: URL,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    // MARK: - Body
    var body: some View {
        if let cached = ImageCacheManager[url] {
            content(.success(cached))
        } else {
            AsyncImage(url: url,
                       scale: scale,
                       transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success (let image) = phase {
            ImageCacheManager[url] = image
        }
        return content(phase)
    }
}
